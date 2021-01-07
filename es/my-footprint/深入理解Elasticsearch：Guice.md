The motivation of using Guice lists here: [Motivation](https://github.com/google/guice/wiki/Motivation).

To create bindings, extend `AbstractModule` and override its `configure` method. In the method body, call `bind()` to specify each binding. These methods are type checked so the compiler can report errors if you use the wrong types. Once you've created your modules, pass them as arguments to `Guice.createInjector()` to build an injector.

Elasticsearch has a `ModulesBuilder` which is responsible for assembling modules. 

```java
public class ModulesBuilder implements Iterable<Module> {

    // container for all Module
    private final List<Module> modules = new ArrayList<>();

    // add new Modules into container
    public ModulesBuilder add(Module... newModules) {
        Collections.addAll(modules, newModules);
        return this;
    }

    @Override
    public Iterator<Module> iterator() {
        return modules.iterator();
    }

    public Injector createInjector() {
        Injector injector = Guice.createInjector(modules);
        ((InjectorImpl) injector).clearCache();
        // in ES, we always create all instances as if they are eager singletons
        // this allows for considerable memory savings (no need to store construction info) as well as cycles
        ((InjectorImpl) injector).readOnlyAllSingletons();
        return injector;
    }
}
```

A `Node` represents a node within a cluster. `Node` is made up of many `Modules` with the help of `ModulesBuilder`. Here is the short version of `Node` class.

```java
public class Node implements Closeable {
    private final Injector injector;
    
    protected Node(final Environment environment, Collection<Class<? extends Plugin>> classpathPlugins) {
        ModulesBuilder modules = new ModulesBuilder();
        modules.add(pluginModule)        
        modules.add(clusterModule);
        modules.add(indicesModule);
        modules.add(actionModule);
        modules.add(new GatewayModule());
        modules.add(settingsModule);
        modules.add(new RepositoriesModule(this.environment, pluginsService.filterPlugins(RepositoryPlugin.class), xContentRegistry));
        modules.add(b -> {
                    b.bind(Node.class).toInstance(this);
                    b.bind(NodeService.class).toInstance(nodeService);
                    b.bind(NamedXContentRegistry.class).toInstance(xContentRegistry);
                    b.bind(PluginsService.class).toInstance(pluginsService);
                    b.bind(Client.class).toInstance(client);
                    b.bind(NodeClient.class).toInstance(client);
                    b.bind(Environment.class).toInstance(this.environment);
                    b.bind(ThreadPool.class).toInstance(threadPool);
                    b.bind(NodeEnvironment.class).toInstance(nodeEnvironment);
                    b.bind(TribeService.class).toInstance(tribeService);
                    b.bind(ResourceWatcherService.class).toInstance(resourceWatcherService);
                    b.bind(CircuitBreakerService.class).toInstance(circuitBreakerService);
                    b.bind(BigArrays.class).toInstance(bigArrays);
                    b.bind(ScriptService.class).toInstance(scriptModule.getScriptService());
                    b.bind(AnalysisRegistry.class).toInstance(analysisModule.getAnalysisRegistry());
                    b.bind(IngestService.class).toInstance(ingestService);
                    b.bind(UsageService.class).toInstance(usageService);
                    b.bind(NamedWriteableRegistry.class).toInstance(namedWriteableRegistry);
                    b.bind(MetaDataUpgrader.class).toInstance(metaDataUpgrader);
                    b.bind(MetaStateService.class).toInstance(metaStateService);
                    b.bind(IndicesService.class).toInstance(indicesService);
                    b.bind(SearchService.class).toInstance(newSearchService(clusterService, indicesService,
                        threadPool, scriptModule.getScriptService(), bigArrays, searchModule.getFetchPhase(),
                        responseCollectorService));
                    b.bind(SearchTransportService.class).toInstance(searchTransportService);
                    b.bind(SearchPhaseController.class).toInstance(new SearchPhaseController(settings, bigArrays,
                            scriptModule.getScriptService()));
                    b.bind(Transport.class).toInstance(transport);
                    b.bind(TransportService.class).toInstance(transportService);
                    b.bind(NetworkService.class).toInstance(networkService);
                    b.bind(UpdateHelper.class).toInstance(new UpdateHelper(settings, scriptModule.getScriptService()));
                    b.bind(MetaDataIndexUpgradeService.class).toInstance(new MetaDataIndexUpgradeService(settings, xContentRegistry,
                        indicesModule.getMapperRegistry(), settingsModule.getIndexScopedSettings(), indexMetaDataUpgraders));
                    b.bind(ClusterInfoService.class).toInstance(clusterInfoService);
                    b.bind(Discovery.class).toInstance(discoveryModule.getDiscovery());
                    {
                        RecoverySettings recoverySettings = new RecoverySettings(settings, settingsModule.getClusterSettings());
                        processRecoverySettings(settingsModule.getClusterSettings(), recoverySettings);
                        b.bind(PeerRecoverySourceService.class).toInstance(new PeerRecoverySourceService(settings, transportService,
                                indicesService, recoverySettings));
                        b.bind(PeerRecoveryTargetService.class).toInstance(new PeerRecoveryTargetService(settings, threadPool,
                                transportService, recoverySettings, clusterService));
                                }
                    httpBind.accept(b);
                    pluginComponents.stream().forEach(p -> b.bind((Class) p.getClass()).toInstance(p));
                }
            );

        // at this point, modules finishs its mission,
        // and injector would take over.
        // since we've got the injector, we can build objects.
        injector = modules.createInjector();
    }

    public Node start() throws NodeValidationException {
        // get any instance from injector, and call its method if you want
        injector.getInstance(IndicesServer.class).start();
        injector.getInstance(SearchService.class).start();
        // ...
    }

    private Node stop() {
        injector.getInstance(TribeService.class).stop();
        injector.getInstance(SnapshotsService.class).stop();
        // ...
    }
}
```

In order to better understanding of `Module`, take `indicesModule` for penetration.

```java
/**
 * Configures classes and services that are shared by indices on each node.
 */
public class IndicesModule extends AbstractModule {

    /**
     * Guice needs to be configured to build the dependency graph exactly.
     */
    @Override
    protected void configure() {
        bind(IndicesStore.class).asEagerSingleton();
        bind(IndicesClusterStateService.class).asEagerSingleton();
        bind(SyncedFlushService.class).asEagerSingleton();
        bind(TransportNodesListShardStoreMetaData.class).asEagerSingleton();
        bind(GlobalCheckpointSyncAction.class).asEagerSingleton();
        bind(TransportResyncReplicationAction.class).asEagerSingleton();
        bind(PrimaryReplicaSyncer.class).asEagerSingleton();
    }
}
```
