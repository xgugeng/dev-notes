<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [环境变量](#%E7%8E%AF%E5%A2%83%E5%8F%98%E9%87%8F)
- [设置提示](#%E8%AE%BE%E7%BD%AE%E6%8F%90%E7%A4%BA)
- [设置默认](#%E8%AE%BE%E7%BD%AE%E9%BB%98%E8%AE%A4)
- [日志配置](#%E6%97%A5%E5%BF%97%E9%85%8D%E7%BD%AE)
- [重要配置](#%E9%87%8D%E8%A6%81%E9%85%8D%E7%BD%AE)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

Elasticsearch默认配置已经够好，顶多需要一些微调。大多数的设置可用通过 API 修改。

Elasticsearch有两个配置文件：

- `elasticsearch.yml` 配置Elasticsearch
- `log4j2.properties`配置Elasticsearch logging

这两个文件默认存在`$ES_HOME/config`目录下，亦可以通过`path.conf`来修改路径。

```shell
./bin/elasticsearch -Epath.conf=/path/to/my/config/
```

配置文件的格式是 YAML。

# 环境变量

引用环境变量使用 `${...}`：

```
node.name:    ${HOSTNAME}
network.host: ${ES_NETWORK_HOST}
```

# 设置提示

打开`${prompt.text}`或`{prompt.secret}`可以在Elasticsearch启动时提示设置属性。

`${prompt.secret}`关闭了设置的回显。

# 设置默认

新的默认设置可以在命令行中用`default.`前缀表示。如果配置文件中没有该选项，那么即使用该值作为实际值。

```shell
./bin/elasticsearch -Edefault.node.name=My_Node
```

# 日志配置

Elasticsearch使用 Log4j 2 记录日志 `${sys:es.logs}`配置可以修改日志文件的位置。比如，你的日志目录 (`path.logs`) 是`/var/log/elasticsearch` ，集群名称为 `production` ，那么 `${sys:es.logs}` 将被解析为 `/var/log/elasticsearch/production`.

```properties
appender.rolling.type = RollingFile 
appender.rolling.name = rolling
appender.rolling.fileName = ${sys:es.logs}.log 
appender.rolling.layout.type = PatternLayout
appender.rolling.layout.pattern = [%d{ISO8601}][%-5p][%-25c] %.10000m%n
appender.rolling.filePattern = ${sys:es.logs}-%d{yyyy-MM-dd}.log 
appender.rolling.policies.type = Policies
appender.rolling.policies.time.type = TimeBasedTriggeringPolicy 
appender.rolling.policies.time.interval = 1 
appender.rolling.policies.time.modulate = true 
```

# 重要配置

- `path.data` and `path.logs`

  这两个配置决定了Elasticsearch的数据和日志路径。其中`path.data`而已配置多个路径。

- `cluster.name`

  默认为`elasticsearch`。集群名称不能重复。

- `node.name`

  节点已经启动，名称就不可变。

- `bootstrap.memory_lock`

  JVM 不被交换到硬盘对于节点健康很重要，一种实现方式是将`bootstrap.memory_lock`设置成`true`。

- `network.host`

  Elasticsearch 默认只绑定 loopback 地址(`127.0.0.1`和`[::1]`)，多节点在一个 server 上启动也是可行的，生产环境下不建议罢了。

- `discovery.zen.ping.unicast.hosts`

  同一个 server 上的节点将扫描端口号 9300 到 9305 来尝试连接其他该 server 上的节点。和其他 server 节点组成集群时，需要配置该项。端口默认 9300，域名对应多IP的话会尝试所有解析出来的 IP。

  ```yaml
  discovery.zen.ping.unicast.hosts:
     - 192.168.1.10:9300
     - 192.168.1.11 
     - seeds.mydomain.com
  ```

- `discovery.zen.minimum_master_nodes`

  不设置的话可能出现脑裂问题，造成数据丢失。为了避免这样，该项设置为(master_eligible_nodes / 2) + 1。