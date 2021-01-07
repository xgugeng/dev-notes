Elasticsearch的节点由`org.elasticsearch.node.Node`表示。

```java
// constructor
protected Node(final Environment environment, Collection<Class<? extends Plugin>> classpathPlugins) {
  // register everything we need to release in the case of an error
  final List<Closeable> resourcesToClose = new ArrayList<>();

  // create the node environment
  nodeEnvironment = new NodeEnvironment(tmpSettings, environment);
  resourcesToClose.add(nodeEnvironment);

  this.pluginsService = new PluginsService(tmpSettings, environment.modulesFile(), environment.pluginsFile(), classpathPlugins);
this.settings = pluginsService.updatedSettings();
  localNodeFactory = new LocalNodeFactory(settings, nodeEnvironment.nodeId());

  // create the environment based on the finalized (processed) view of the settings
  // this is just to makes sure that people get the same settings, no matter where they ask them from
  this.environment = new Environment(this.settings);


  final List<ExecutorBuilder<?>> executorBuilders = pluginsService.getExecutorBuilders(settings);

  // init a ThreadPool for executors
  final ThreadPool threadPool = new ThreadPool(settings, executorBuilders.toArray(new ExecutorBuilder[0]));
  resourcesToClose.add(() -> ThreadPool.terminate(threadPool, 10, TimeUnit.SECONDS));

  // adds the context to the DeprecationLogger so that it does not need to be injected everywhere
  DeprecationLogger.setThreadContext(threadPool.getThreadContext());
  resourcesToClose.add(() -> DeprecationLogger.removeThreadContext(threadPool.getThreadContext()));


  // Module Container
  ModulesBuilder modules = new ModulesBuilder();
  modules.add(pluginModule);
  modules.add(clusterModule);
  // ...

  // for start each modules in start()
  injector = modules.createInjector();


  List<LifecycleComponent> pluginLifecycleComponents = pluginComponents.stream()
                .filter(p -> p instanceof LifecycleComponent)
                .map(p -> (LifecycleComponent) p).collect(Collectors.toList());
            pluginLifecycleComponents.addAll(pluginsService.getGuiceServiceClasses().stream()
                .map(injector::getInstance).collect(Collectors.toList()));
            resourcesToClose.addAll(pluginLifecycleComponents);
            this.pluginLifecycleComponents = Collections.unmodifiableList(pluginLifecycleComponents);
            client.initialize(injector.getInstance(new Key<Map<GenericAction, TransportAction>>() {}),
                    () -> clusterService.localNode().getId());

  actionModule.initRestHandlers(() -> clusterService.state().nodes());

}
```

```java
// Start the node. If the node is already started, this method is no-op.
public Node start() throws NodeValidationException {
  if (!lifecycle.moveToStarted()) {
    return this;
  }

  // start each module
  injector.getInstance(IndicesService.class).start();
  // ...

}
```

