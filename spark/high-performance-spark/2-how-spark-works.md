<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [How Spark fits into the Big Data Ecosystem](#how-spark-fits-into-the-big-data-ecosystem)
- [Spark Model on Parallel Computing: RDD](#spark-model-on-parallel-computing-rdd)
  - [Lazy evaluation](#lazy-evaluation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# How Spark fits into the Big Data Ecosystem

More often, Spark is used in tandem with a distributed storage system (e.g., HDFS, Cassandra, or S3) and a cluster manager — the storage system to house the data processed with Spark, and the cluster manager to orchestrate the distribution of Spark applications across the cluster. Spark currently supports three kinds of cluster managers: Standalone Cluster Manager, Apache Mesos, and Hadoop YARN

The Standalone Cluster Manager is included in Spark, but using the Standalone manager requires installing Spark on each node of the cluster.

Spark is built around a data abstraction called Resilient Distributed Datasets (RDDs). RDDs are a representation of lazily evaluated, statically typed, distributed collections. RDDs have a number of predefined “coarse-grained” transformations (functions that are applied to the entire dataset), such as map , join , and reduce to manipulate the distributed datasets, as well as I/O functionality to read and write data between the distributed storage system and the Spark JVMs.

Spark SQL defines an interface for a semi-structured data type, called DataFrames

Spark has two machine learning packages: ML and MLlib. 

- MLlib is a package of machine learning and statistics algorithms written with Spark.
- Spark ML provides a higher-level API than MLlib with the goal of allowing users to more easily create practical machine learning pipelines. 

Spark MLlib is primarily built on top of RDDs and uses functions from Spark Core, while ML is built on top of Spark SQL DataFrames

Spark Streaming uses the scheduling of the Spark Core for streaming analytics on minibatches of data.

# Spark Model on Parallel Computing: RDD

Spark allows users to write a program for the driver (or master node) on a cluster computing system that can perform operations on data in parallel. Spark represents large datasets as RDDs — immutable, distributed collections of objects — which are stored in the executors (or slave nodes). The objects that comprise RDDs are called partitions and may be (but do not need to be) computed on different nodes of a distributed system. The Spark cluster manager handles starting and distributing the Spark executors across a distributed system according to the configuration parameters set by the Spark application. The Spark execution engine itself distributes data across the executors for a computation.

Spark evaluates RDDs lazily, computing RDD transformations only when the final RDD data needs to be computed

Spark can keep an RDD loaded in-memory on the executor nodes throughout the life of a Spark application for faster access in repeated computations.

RDDs are immutable, so transforming an RDD returns a new RDD rather than the existing one.

Spark does not begin computing the partitions until an action is called. An action is a Spark operation that returns something other than an RDD, triggering evaluation of partitions and possibly returning some output to a non-Spark system

Actions trigger the scheduler, which builds a directed acyclic graph (called the DAG), based on the dependencies between RDD transformations.

Spark evaluates an action by working backward to define the series of steps it has to take to produce each object in the final distributed dataset (each partition). Then, using this series of steps, called the execution plan, the scheduler computes the missing partitions for each stage until it computes the result.

## Lazy evaluation

Lazy evaluation allows Spark to combine operations that don’t require communication with the driver (called transformations with one-to-one dependencies) to avoid doing multiple passes through the data.

**Lazy evaluation and fault tolerance**

Spark’s unique method of fault tolerance is achieved because each partition of the data contains the dependency information needed to recalculate the partition.

Spark does not need to maintain a log of updates to each RDD or log the actual intermediary steps, since the RDD itself contains all the dependency information needed to replicate each of its partitions. Thus, if a partition is lost, the RDD has enough information about its lineage to recompute it, and that computation can be parallelized to make recovery faster.

**Lazy evaluation and debugging**

Lazy evaluation has important consequences for debugging since it means that a Spark program will fail only at the point of action.

