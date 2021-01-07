<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Command、SettingsCommand、ElasticSearch](#commandsettingscommandelasticsearch)
- [Bootstrap](#bootstrap)
- [Node](#node)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

Elasticsearch的安装步骤在此不再详述，请见[官方文档](https://www.elastic.co/guide/en/elasticsearch/reference/current/_installation.html)。

安装成功之后，打开文件`$ES_HOME/bin/elasticsearch`：

```shell
cd elasticsearch-5.0.1/bin
vi elasticsearch
```

其中最关键的代码块如下：

```shell
exec "$JAVA" $ES_JAVA_OPTS -Des.path.home="$ES_HOME" -cp "$ES_CLASSPATH" org.elasticsearch.bootstrap.Elasticsearch "$@"
```

据此我们找到Elasticsearch的入口为`org.elasticsearch.bootstrap.Elasticsearch`。


![class.png](http://upload-images.jianshu.io/upload_images/743520-aab3761e94b865e1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


#  Command、SettingsCommand、ElasticSearch

`xxxOption`属性负责保存命令行的启动参数，基于`joptsimple.OptionParser`包。

真正干活的是`main`函数，它调用`Bootstrap.init()`来完成启动工作。

```java
class Elasticsearch extends SettingCommand {
    private final OptionSpecBuilder versionOption;
    private final OptionSpecBuilder daemonizeOption;
    private final OptionSpec<Path> pidfileOption;
    private final OptionSpecBuilder quietOption;

    // visible for testing
    Elasticsearch() {
        super("starts elasticsearch");
        versionOption = parser.acceptsAll(Arrays.asList("V", "version"),
            "Prints elasticsearch version information and exits");
        daemonizeOption = parser.acceptsAll(Arrays.asList("d", "daemonize"),
            "Starts Elasticsearch in the background")
            .availableUnless(versionOption);
        pidfileOption = parser.acceptsAll(Arrays.asList("p", "pidfile"),
            "Creates a pid file in the specified path on start")
            .availableUnless(versionOption)
            .withRequiredArg()
            .withValuesConvertedBy(new PathConverter());
        quietOption = parser.acceptsAll(Arrays.asList("q", "quiet"),
            "Turns off standard ouput/error streams logging in console")
            .availableUnless(versionOption)
            .availableUnless(daemonizeOption);
    }

    /**
     * 启动 ES 的入口函数
     */
    public static void main(final String[] args) throws Exception {
        System.setSecurityManager(new SecurityManager() {
            @Override
            public void checkPermission(Permission perm) {
                // grant all permissions so that we can later set the security manager to the one that we want
            }
        });
        final Elasticsearch elasticsearch = new Elasticsearch();
        int status = main(args, elasticsearch, Terminal.DEFAULT);
        if (status != ExitCodes.OK) {
            exit(status);
        }
    }

    void init(final boolean daemonize, final Path pidFile, final boolean quiet, final Map<String, String> esSettings)
        throws NodeValidationException, UserException {
        try {
            // 调用 Bootstrap 的 init 函数 
            Bootstrap.init(!daemonize, pidFile, quiet, esSettings);
        } catch (BootstrapException | RuntimeException e) {
            throw new StartupException(e);
        }
    }
}
```

# Bootstrap

`Bootstrap`的`init`函数中，首先调用`Bootstrap`自己的构造函数，通过`Node`的构造函数生成了一个`node`节点，并且启动了一个`keepaliveThread`线程。线程启动之后就进入到`await`状态；接着，利用`Runtime.getRuntime().addShutdownHook`方法加入一个Hook，在程序退出时触发该Hook（注：退出是指ctrl+c或者kill -15，但如果用kill -9 那是没办法的），在该Hook中会对之前的线程做`countDown`操作，其实这个线程相当于一个心跳，用以来表示ES进程是否还活着。

```java
final class Bootstrap {
    /** creates a new instance */
    Bootstrap() {
        keepAliveThread = new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    keepAliveLatch.await();
                } catch (InterruptedException e) {
                    // bail out
                }
            }
        }, "elasticsearch[keepAlive/" + Version.CURRENT + "]");
        keepAliveThread.setDaemon(false);
        // keep this thread alive (non daemon thread) until we shutdown
        Runtime.getRuntime().addShutdownHook(new Thread() {
            @Override
            public void run() {
                keepAliveLatch.countDown();
            }
        });
    }
  
   static void init(
     		final boolean foreground,
            final Path pidFile,
            final boolean quiet,
            final Map<String, String> esSettings) throws BootstrapException, NodeValidationException, UserException {
     INSTANCE = new Bootstrap();
     INSTANCE.setup(true, environment);
     INSTANCE.start();
     
     // 初始化环境
     Environment environment = initialEnvironment(foreground, pidFile, esSettings);
   }
  
    // 启动 node 和 keepAliveThread
    private void start() throws NodeValidationException {
        node.start();
        keepAliveThread.start();
    }

    // 停止 node 和 keepAliveThread
    static void stop() throws IOException {
        try {
            IOUtils.close(INSTANCE.node);
        } finally {
            INSTANCE.keepAliveLatch.countDown();
        }
    }
}
```



# Node

`Node`在构造函数中通过`ModuleBuilder`类来进行模块的注入（Guice的一个封装），同时生成`injector`实例。

在`Node`的`start()`方法中，用`injector`对各个模块完成启动，各自负责各自的功能。

```java
public class Node implements Closeable {
	protected Node(final Environment environment, Collection<Class<? extends Plugin>> classpathPlugins) {
      	// 创建 Node 环境
		nodeEnvironment = new NodeEnvironment(tmpSettings, environment);
    	// ...
        ModulesBuilder modules = new ModulesBuilder();
        for (Module pluginModule : pluginsService.createGuiceModules()) {
            modules.add(pluginModule); // 插件模块
        }
        final MonitorService monitorService = new MonitorService(settings, nodeEnvironment, threadPool);
        modules.add(new NodeModule(this, monitorService));  // 节点模块
        modules.add(new ClusterModule(settings));           //集群模块
        modules.add(new IndicesModule(settings));           //索引模块
        modules.add(new ActionModule(false));               //action模块
        modules.add(new GatewayModule());                   //持久化模块，可用于集群状态恢复
        modules.add(new SettingsModule(settings));        //参数配置模块
        modules.add(new RepositoriesModule());            //容器模块
        modules.add(b -> {
                b.bind(IndicesQueriesRegistry.class).toInstance(searchModule.getQueryParserRegistry());
                b.bind(SearchRequestParsers.class).toInstance(searchModule.getSearchRequestParsers());
                b.bind(SearchExtRegistry.class).toInstance(searchModule.getSearchExtRegistry());
                b.bind(PluginsService.class).toInstance(pluginsService);
                b.bind(Client.class).toInstance(client);
                b.bind(NodeClient.class).toInstance(client); //节点客户端模块
                b.bind(Environment.class).toInstance(this.environment);
                b.bind(ThreadPool.class).toInstance(threadPool);
                b.bind(NodeEnvironment.class).toInstance(nodeEnvironment); //节点环境模块
                b.bind(TribeService.class).toInstance(tribeService); //部族模块，允许不同集群互相注册访问
                b.bind(ResourceWatcherService.class).toInstance(resourceWatcherService); //资源监控模块
                b.bind(CircuitBreakerService.class).toInstance(circuitBreakerService); // 分词模块
                b.bind(BigArrays.class).toInstance(bigArrays);
                b.bind(ScriptService.class).toInstance(scriptModule.getScriptService()); //本地脚本模块，支持groovy,mustache,lucene expressions
                b.bind(AnalysisRegistry.class).toInstance(analysisModule.getAnalysisRegistry());
                b.bind(IngestService.class).toInstance(ingestService);
                b.bind(NamedWriteableRegistry.class).toInstance(namedWriteableRegistry);
                b.bind(MetaDataUpgrader.class).toInstance(metaDataUpgrader);
                b.bind(MetaStateService.class).toInstance(metaStateService);
                b.bind(IndicesService.class).toInstance(indicesService); //索引模块
                b.bind(SearchService.class).toInstance(newSearchService(clusterService, indicesService,
                    threadPool, scriptModule.getScriptService(), bigArrays, searchModule.getFetchPhase()));
                b.bind(SearchTransportService.class).toInstance(new SearchTransportService(settings, transportService)); //搜索模块
                b.bind(SearchPhaseController.class).toInstance(new SearchPhaseController(settings, bigArrays,
                        scriptModule.getScriptService()));
                b.bind(Transport.class).toInstance(transport);
                b.bind(TransportService.class).toInstance(transportService);
                b.bind(NetworkService.class).toInstance(networkService); 
                b.bind(AllocationCommandRegistry.class).toInstance(NetworkModule.getAllocationCommandRegistry());
                b.bind(UpdateHelper.class).toInstance(new UpdateHelper(settings, scriptModule.getScriptService()));
                b.bind(MetaDataIndexUpgradeService.class).toInstance(new MetaDataIndexUpgradeService(settings,
                    indicesModule.getMapperRegistry(), settingsModule.getIndexScopedSettings()));
                b.bind(ClusterInfoService.class).toInstance(clusterInfoService);
                b.bind(Discovery.class).toInstance(discoveryModule.getDiscovery());
                {
                    RecoverySettings recoverySettings = new RecoverySettings(settings, settingsModule.getClusterSettings());
                    processRecoverySettings(settingsModule.getClusterSettings(), recoverySettings);
                    b.bind(PeerRecoverySourceService.class).toInstance(new PeerRecoverySourceService(settings, transportService,
                            indicesService, recoverySettings, clusterService));
                    b.bind(PeerRecoveryTargetService.class).toInstance(new PeerRecoveryTargetService(settings, threadPool,
                            transportService, recoverySettings, clusterService));
                }
                httpBind.accept(b);
                pluginComponents.stream().forEach(p -> b.bind((Class) p.getClass()).toInstance(p));
            }
        );
      
        // 创建 injector
        injector = modules.createInjector();
    }

    // 启动 Node 
    public Node start() throws NodeValidationException { 
        injector.getInstance(MappingUpdatedAction.class).setClient(client);
        injector.getInstance(IndicesService.class).start();
        injector.getInstance(IndicesClusterStateService.class).start();
        injector.getInstance(SnapshotsService.class).start();
        injector.getInstance(SnapshotShardsService.class).start();
        injector.getInstance(RoutingService.class).start();
        injector.getInstance(SearchService.class).start();
        injector.getInstance(MonitorService.class).start();
        injector.getInstance(RestController.class).start();

        // ...
        if (NetworkModule.HTTP_ENABLED.get(settings)) {
            injector.getInstance(HttpServer.class).start();
        }
    }
```

至此，ES的启动过程就完成了。