<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [`IndicesService`](#indicesservice)
- [`IndexService`](#indexservice)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

`org.elasticsearch.indices.IndicesService` was responsible for providing index service for Elasticsearch.

`org.elasticsearch.index.IndexService` is one helper of  `IndicesService` for detail job.

# `IndicesService`

All services involved in Elasticsearch inherit from `AbstractLifecycleComponent`, so does `IndicesService`.

```java
public class IndicesService extends AbstractLifecycleComponent
    implements IndicesClusterStateService.AllocatedIndices<IndexShard, IndexService>, IndexService.ShardStoreDeleter {


// constructor
    public IndicesService(Settings settings, PluginsService pluginsService, NodeEnvironment nodeEnv, NamedXContentRegistry xContentRegistry,
                          ClusterSettings clusterSettings, AnalysisRegistry analysisRegistry,
                          IndexNameExpressionResolver indexNameExpressionResolver,
                          MapperRegistry mapperRegistry, NamedWriteableRegistry namedWriteableRegistry,
                          ThreadPool threadPool, IndexScopedSettings indexScopedSettings, CircuitBreakerService circuitBreakerService,
                          BigArrays bigArrays, ScriptService scriptService, ClusterService clusterService, Client client,
                          MetaStateService metaStateService)

    @Override
    protected void doStart() {
        // Start thread that will manage cleaning the field data cache periodically
        threadPool.schedule(this.cleanInterval, ThreadPool.Names.SAME, this.cacheCleaner);
    }

    Override
    protected void doStop() {
        ExecutorService indicesStopExecutor = Executors.newFixedThreadPool(5, EsExecutors.daemonThreadFactory("indices_shutdown"));

        // Copy indices because we modify it asynchronously in the body of the loop
        final Set<Index> indices = this.indices.values().stream().map(s -> s.index()).collect(Collectors.toSet());
        final CountDownLatch latch = new CountDownLatch(indices.size());
        for (final Index index : indices) {
            indicesStopExecutor.execute(() -> {
                try {
                    removeIndex(index, IndexRemovalReason.NO_LONGER_ASSIGNED, "shutdown");
                } finally {
                    latch.countDown();
                }
            });
        }
        try {
            if (latch.await(shardsClosedTimeout.seconds(), TimeUnit.SECONDS) == false) {
              logger.warn("Not all shards are closed yet, waited {}sec - stopping service", shardsClosedTimeout.seconds());
            }
        } catch (InterruptedException e) {
            // ignore
        } finally {
            indicesStopExecutor.shutdown();
        }
    }

    @Override
    protected void doClose() {
        IOUtils.closeWhileHandlingException(analysisRegistry, indexingMemoryController, indicesFieldDataCache, cacheCleaner, indicesRequestCache, indicesQueryCache);
    }

    // Returns the node stats indices stats by extracting data from
    // 1. oldShardsStats
    // 2. indexShard
    public NodeIndicesStats stats(boolean includePrevious, CommonStatsFlags flags)

    // operations on Map<String, IndexService> indices
    public boolean hasIndex(Index index)
    public IndexService indexService(Index index)
    public IndexService indexServiceSafe(Index index)

    // Creates a new IndexService for the given metadata
    public synchronized IndexService createIndex(IndexMetaData indexMetaData, List<IndexEventListener> builtInListeners, Consumer<ShardId> globalCheckpointSyncer) throws IOException {

        // check lifecycle.started from parent class: AbstractLifecycleComponent
        ensureChangesAllowed();

        // check index's UUID and its exist
        if (indexMetaData.getIndexUUID().equals(IndexMetaData.INDEX_UUID_NA_VALUE)) {
            throw new IllegalArgumentException("index must have a real UUID found value: [" + indexMetaData.getIndexUUID() + "]");
        }

        // get index from meta data
        final Index index = indexMetaData.getIndex();
        if (hasIndex(index)) {
            throw new ResourceAlreadyExistsException(index);
        }

        // add Event Listeners
        List<IndexEventListener> finalListeners = new ArrayList<>(builtInListeners);
        final IndexEventListener onStoreClose = new IndexEventListener() {
            @Override
            public void onStoreClosed(ShardId shardId) {
                indicesQueryCache.onClose(shardId);
            }
        };
        finalListeners.add(onStoreClose);
        finalListeners.add(oldShardsStats);
        final IndexService indexService =
            createIndexService(
                "create index",
                indexMetaData,
                indicesQueryCache,
                indicesFieldDataCache,
                finalListeners,
                globalCheckpointSyncer,
                indexingMemoryController);
        boolean success = false;
        try {
            indexService.getIndexEventListener().afterIndexCreated(indexService);
            indices = newMapBuilder(indices).put(index.getUUID(), indexService).immutableMap();
            success = true;
            return indexService;
        } finally {
            if (success == false) {
                indexService.close("plugins_failed", true);
            }
        }
    }

    // This creates a new IndexService without registering it
    private synchronized IndexService createIndexService(final String reason,
                                                         IndexMetaData indexMetaData, IndicesQueryCache indicesQueryCache,
                                                         IndicesFieldDataCache indicesFieldDataCache,
                                                         List<IndexEventListener> builtInListeners,
                                                         Consumer<ShardId> globalCheckpointSyncer,
                                                         IndexingOperationListener... indexingOperationListeners) throws IOException {
        final Index index = indexMetaData.getIndex();
        final IndexSettings idxSettings = new IndexSettings(indexMetaData, this.settings, indexScopeSetting);

        final IndexModule indexModule = new IndexModule(idxSettings, analysisRegistry);
        for (IndexingOperationListener operationListener : indexingOperationListeners) {
            indexModule.addIndexOperationListener(operationListener);
        }
        pluginsService.onIndexModule(indexModule);
        for (IndexEventListener listener : builtInListeners) {
            indexModule.addIndexEventListener(listener);
        }
        return indexModule.newIndexService(
            nodeEnv,
            xContentRegistry,
            this,
            circuitBreakerService,
            bigArrays,
            threadPool,
            scriptService,
            clusterService,
            client,
            indicesQueryCache,
            mapperRegistry,
            globalCheckpointSyncer,
            indicesFieldDataCache);
    }

}
```

The following methods are operations on **Index**. 

```java
// create shard 
// 1. get index from ShardRouting
// 2. get IndexService 
// 3. IndexService.createShard
public IndexShard createShard(ShardRouting shardRouting, RecoveryState recoveryState, PeerRecoveryTargetService recoveryTargetService,
                                  PeerRecoveryTargetService.RecoveryListener recoveryListener, RepositoriesService repositoriesService,
                                  Callback<IndexShard.ShardFailure> onShardFailure) throws IOException

// 1. IndexService.remove
// 2. call deleteIndexStore for wiping data from disk
public void removeIndex(final Index index, final IndexRemovalReason reason, final String extraInfo)

// Deletes an index that is not assigned to this node. This method cleans up all disk folders relating to the index
// but does not deal with in-memory structures. For those call {@link #removeIndex(Index, IndexRemovalReason, String)}
// 1. get index from meta
// 2. deleteIndexStore
public void deleteUnassignedIndex(String reason, IndexMetaData metaData, ClusterState clusterState)

/**
Deletes the index store trying to acquire all shards locks for this index
This method will delete the metadata for the index even if the actual shards can't be locked.
Call deleteIndexStoreIfDeletionAllowed if deletion is allowed.
deleteIndexStoreIfDeletionAllowed would use NodeEnvironment's deleteIndexDirectorySafe to delete folder safely, then MetaDataStateFormat.deleteMetaState for wiping metadata so that this index doesn't get re-imported as a dangling index.
**/
void deleteIndexStore(String reason, IndexMetaData metaData, ClusterState clusterState) throws IOException 

/**
Deletes the shard with an already acquired shard lock.
NodeEnvironment's deleteShardDirectoryUnderLock take the following responsiblity.
**/
 public void deleteShardStore(String reason, ShardLock lock, IndexSettings indexSettings) throws IOException

/**
This method deletes the shard contents on disk for the given shard ID. This method will fail if the shard deleting is prevented by canDeleteShardContent(ShardId, IndexSettings) of if the shards lock can not be acquired.
On data nodes, if the deleted shard is the last shard folder in its index, the method will attempt to remove the index folder as well.

1. NodeEnvironment's deleteShardDirectorySafe
2. Data nodes would delete the index store, master nodes keep the index mata data, even if having no shards
**/
public void deleteShardStore(String reason, ShardId shardId, ClusterState clusterState) throws IOException, ShardLockObtainFailedException

/**
index contents can be deleted if the index is not on a shared file system,
or if its on a shared file system but its an already closed index (so all
its resources have already been relinquished)
**/
public boolean canDeleteIndexContents(Index index, IndexSettings indexSettings)

/**
return false if the shared doesn't exist
**/
public ShardDeletionCheckResult canDeleteShardContent(ShardId shardId, IndexSettings indexSettings) 

public void addPendingDelete(ShardId shardId, IndexSettings settings)
public void addPendingDelete(Index index, IndexSettings settings)

/**
Processes all pending deletes for the given index. This method will acquire all locks for the given 
index and will
process all pending deletes for this index. Pending deletes might occur if the OS doesn't allow deletion of files because
they are used by a different process ie. on Windows where files might still be open by a virus scanner. On a shared
filesystem a replica might not have been closed when the primary is deleted causing problems on delete calls so we
schedule there deletes later.
**/
public void processPendingDeletes(Index index, IndexSettings indexSettings, TimeValue timeout)throws IOException, InterruptedException, ShardLockObtainFailedException

```

`FieldDataCacheCleaner` is a *scheduled Runnable* used to clean a Guava cache periodically. In this case it is the field data cache, because a cache that has an entry invalidated may not clean up the entry if it is not read from or written to after invalidation.

```java
private static final class CacheCleaner implements Runnable, Releasable
```

then here come the methods relative to request cache.

```java
// Can the shard request be cached at all?
public boolean canCache(ShardSearchRequest request, SearchContext context) 

public void clearRequestCache(IndexShard shard)

/**
Loads the cache result, computing it if needed by executing the query phase and otherwise deserializing the cached
value into the {@link SearchContext#queryResult() context's query result}. The combination of load + compute allows
to have a single load operation that will cause other requests with the same key to wait till its loaded an reuse
the same cache.
**/
public void loadIntoContext(ShardSearchRequest request, SearchContext context, QueryPhase queryPhase) throws Exception

// Cache something calculated at the shard level.
 private BytesReference cacheShardLevelResult(IndexShard shard, DirectoryReader reader, BytesReference cacheKey, Consumer<StreamOutput> loader) throws Exception 
```

# `IndexService`

```java
public class IndexService extends AbstractIndexComponent implements IndicesClusterStateService.AllocatedIndex<IndexShard> {
    private volatile Map<Integer, IndexShard> shards = emptyMap();

    // shards relative based shards Map
    public int numberOfShards()
    public boolean hasShard(int shardId)
    public IndexShard getShardOrNull(int shardId)

    public synchronized void close(final String reason, boolean delete) throws IOException {
        if (closed.compareAndSet(false, true)) {
            deleted.compareAndSet(false, delete);
            try {
                final Set<Integer> shardIds = shardIds();
                for (final int shardId : shardIds) {
                    try {
                        removeShard(shardId, reason);
                    } catch (Exception e) {
                        logger.warn("failed to close shard", e);
                    }
                }
            } finally {
                IOUtils.close(bitsetFilterCache, indexCache, indexFieldData, mapperService, refreshTask, fsyncTask, globalCheckpointTask);
            }
        }
    }

/**
1. get lock from NodeEnvironment
2. load shared path
3. new Store, then IndexShard
**/ 
    public synchronized IndexShard createShard(ShardRouting routing) throws IOException;

/**
remove Shard from shars Map, then close Shard
**/
    public synchronized void removeShard(int shardId, String reason)

/**
close based on IndexShard
**/
    private void closeShard(String reason, ShardId sId, IndexShard indexShard, Store store, IndexEventListener listener)

/**
1. IndexSettings's updateIndexMetaData
2. reschedule refresh and Fsync tasks
**/
    public synchronized void updateMetaData(final IndexMetaData metadata)
}

```

Three aysnc tasks are running background for refresh, fsync, checkpoint. they all based on `IndexService` to finish their mission.

```java

private volatile AsyncRefreshTask refreshTask;
private volatile AsyncTranslogFSync fsyncTask;
private final AsyncGlobalCheckpointTask globalCheckpointTask;

abstract static class BaseAsyncTask implements Runnable, Closeable {
    public final void run()
}
static final class AsyncTranslogFSync extends BaseAsyncTask {
    protected void runInternal() {
        indexService.maybeFSyncTranslogs();
    }
}

final class AsyncRefreshTask extends BaseAsyncTask {
    protected void runInternal() {
        indexService.maybeRefreshEngine();
    }
}

final class AsyncGlobalCheckpointTask extends BaseAsyncTask {
    protected void runInternal() {
        indexService.maybeUpdateGlobalCheckpoints();
    }
}

// Fsync translogs to disk by 
// 1. get Translog from IndexShard
// 2. TransLog sync
private void maybeFSyncTranslogs() 

// IndexShard's refresh
private void maybeRefreshEngine() 

// IndexShard's updateGlobalCheckpointOnPrimary
private void maybeUpdateGlobalCheckpoints()
```
