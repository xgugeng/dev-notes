<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [20.1 Basic Concepts](#201-basic-concepts)
- [20.2 Concurrent Programming and Python](#202-concurrent-programming-and-python)
- [20.3 `multiprocessing`](#203-multiprocessing)
  - [Processes](#processes)
  - [Interprocess Communication](#interprocess-communication)
  - [Process Pools](#process-pools)
  - [Shared Data and Synchronization](#shared-data-and-synchronization)
  - [Managed Objects](#managed-objects)
  - [Connections](#connections)
  - [Miscellaneous Utility Functions](#miscellaneous-utility-functions)
- [20.4 `threading`](#204-threading)
  - [`Timer` Objects](#timer-objects)
  - [`Lock` Objects](#lock-objects)
  - [Semaphore and Bounded Semaphore](#semaphore-and-bounded-semaphore)
  - [Events](#events)
  - [Condition Variables](#condition-variables)
  - [Thread Termination and Suspension](#thread-termination-and-suspension)
  - [Utility Functions](#utility-functions)
- [20.5 `queue`, `Queue`](#205-queue-queue)
- [20.6 Coroutines and Microthreading](#206-coroutines-and-microthreading)
- [Navigation](#navigation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 20.1 Basic Concepts

A running program is called a `process`. Each process has its own system state, which includes memory, lists of open files, a program counter that keeps track of the instruction being executed, and a call stack used to hold the local variables of functions.

A `thread` is similar to a process in that it has its own control flow and execution stack. However, a thread runs inside the process that created it, sharing all of the data and system resources.

Writing programs that take advantage of concurrent execution is something that is intrinsically complicated. A major source of complexity concerns synchronization and access to shared data.

# 20.2 Concurrent Programming and Python

Python supports both **message passing** and **thread-based concurrent programming** on most systems.

*The Python interpreter uses an internal global interpreter lock (the GIL) that only allows a single Python thread to execute at any given moment*. This restricts Python programs to run on a single processor regardless of how many CPU cores might be available on the system.

For applications that involve heavy amounts of CPU processing, using threads to subdivide work doesn’t provide any benefit and will make the program run slower (often much slower than you would guess). For this, you’ll want to rely on subprocesses and message passing.

As a general rule, you really don’t want to be writing programs with 10,000 threads because each thread requires its own system resources and the overhead associated with thread context switching, locking, and other matters starts to become significant (not to mention the fact that all threads are constrained to run on a single CPU). To deal with this, it is somewhat common to see such applications restructured as asynchronous event-handling systems.

# 20.3 `multiprocessing`

The `multiprocessing` module provides support for launching tasks in a subprocess, communicating and sharing data, and performing various forms of synchronization. The programming interface is meant to mimic the programming interface for threads in the `threading` module.

## Processes

`Process([group [, target [, name [, args [, kwargs]]]]])`   A class that represents a task running in a subprocess.

An instance p of Process has the following methods:   

- `p.is_alive()`   Returns True if `p` is still running.   
- `p.join([timeout])`   Waits for process `p` to terminate.
- `p.run()`   The method that runs when the process starts.
- `p.start()`   Starts the process.
- `p.terminate()`   Forcefully terminates the process.

A Process instance p also has the following data attributes:

- `p.daemon`   A Boolean flag that indicates whether or not the process is daemonic
- `p.exitcode`   The integer exit code of the process.
- `p.name`   The name of the process.   
- `p.pid`   The integer process ID of the process.

The threading module provides a Thread class and a variety of synchronization primitives for writing multithreaded programs.

## Interprocess Communication

Two primary forms of interprocess communication are supported by the `multiprocessing` module: pipes and queues. Both methods are implemented using message passing.

`Queue([maxsize])`   Creates a shared process queue.

An instance q of Queue has the following methods:   
- `q.cancel_join_thread()`   Don’t automatically join the background thread on process exit.
- `q.close()`   Closes the queue, preventing any more data from being added to it.
- `q.full()`   Returns True if `q` is full.
- `q.get([block [, timeout]])`   Returns an item from `q`.
- `q.put(item [, block [, timeout]])`   Puts item onto the queue.
- `q.join_thread()`   Joins the queue’s background thread.
- `JoinableQueue([maxsize])`   Creates a joinable shared process queue.
- `q.join()`   Used by a producer to block until all items placed in a queue have been processed.
- `Pipe([duplex])`   Creates a pipe between processes and returns a tuple (conn1, conn2) where conn1 and conn2 are Connection objects representing the ends of the pipe.

An instance `c` of a Connection object returned by `Pipe()` has the following methods and attributes:   

- `c.close()`   Closes the connection.
- `c.poll([timeout])`   Returns True if data is available on the connection.
- `c.recv()`   Receives an object sent by `c.send()`.
- `c.send(obj)`   Sends an object through the connection.

## Process Pools

`Pool([numprocess [,initializer [, initargs]]])`   Creates a pool of worker processes.

An instance `p` of Pool supports the following operations:   

- `p.apply(func [, args [, kwargs]])`   Executes `func(*args, **kwargs)` in one of the pool workers and returns the result.
- `p.apply_async(func [, args [, kwargs [, callback]]])`   Executes `func(*args, **kwargs)` in one of the pool workers and returns the result asynchronously.
- `p.join()`   Waits for all worker processes to exit.
- `p.map(func, iterable [, chunksize])`   Applies the callable object func to all of the items in iterable and returns the result as a list.
- `p.terminate()`   Terminates the subprocess by sending it a SIGTERM signal on UNIX or calling the Win32 API TerminateProcess function on Windows.   
- `p.wait()`   Waits for `p` to terminate and returns the return code.

The methods `apply_async()` and `map_async()` return an `AsyncResult` instance as a result. An instance a of `AsyncResult` has the following methods:  

- `a.get([timeout])`   Returns the result, waiting for it to arrive if necessary. timeout is an optional timeout.
- `a.sucessful()`   Returns True if the call completed without any exceptions.
- `a.wait([timeout])`  Waits for the result to become available.

## Shared Data and Synchronization

`Value(typecode, arg1, ... argN, lock)`   Creates a `ctypes` object in shared memory.

## Managed Objects

The `multiprocessing` module does, however, provide a way to work with shared objects if they run under the control of a so-called manager. A `manager` is a separate subprocess where the real objects exist and which operates as a server. Other processes access the shared objects through the use of proxies that operate as clients of the manager server.

`Manager()`   Creates a running manager server in a separate process.

An instance `m` of `SyncManager` as returned by `Manager()` has a series of methods for creating shared objects and returning a proxy which can be used to access them. Normally, you would create a manager and use these methods to create shared objects before launching any new processes.

- `m.Array(typecode, sequence)`   Creates a shared Array instance on the server and returns a proxy to it.
- `m.Condition([lock])`   Creates a shared threading.Condition instance on the server and returns a proxy to it.
- `m.dict([args])`   Creates a shared dict instance on the server and returns a proxy to it.
- `m.Event()`   Creates a shared threading.Event instance on the server and returns a proxy to it.
- `m.Lock()`   Creates a shared threading.Lock instance on the server and returns a proxy to it.
- `m.Queue()`   Creates a shared Queue.Queue object on the server and returns a proxy to it.

`managers.BaseManager([address [, authkey]])`   Base class used to create custom manager servers for user-defined objects.

An instance `m` of a manager derived from `BaseManager` must be manually started to operate. The following attributes and methods are related to this:   
- `m.address`   A tuple `(hostname, port)` that has the address being used by the manager server.   
- `m.connect()`   Connects to a remote manager object, the address of which was given to the `BaseManager` constructor.
- `m.start()`   Starts a separate subprocess and starts the manager server in that process.

## Connections

Programs that use the `multiprocessing` module can perform message passing with other processes running on the same machine or with processes located on remote systems. This can be useful if you want to take a program written to work on a single system and expand it work on a computing cluster. The `multiprocessing.connection` submodule has functions and classes for this purpose:

`connections.Client(address [, family [, authenticate [, authkey]]])` Connects to another process which must already be listening at address address.

`connections.Listener(address [, family [, backlog [, authenticate [, authkey]]]])` A class that implements a server for listening for and handling connections made by the `Client()` function.

An instance `s` of Listener supports the following methods and attributes:   

- `s.accept()`  Accepts a new connection and returns a Connection object.

## Miscellaneous Utility Functions

- `cpu_count()`   Returns the number of CPUs on the system if it can be determined.
- `freeze_support()`   A function that should be included as the first statement of the main program in an application that will be “frozen” using various packaging tools such as `py2exe`.
- `get_logger()`   Returns the logging object associated with the multiprocessing module, creating it if it doesn’t already exist.


# 20.4 `threading`

The `threading` module provides a Thread class and a variety of synchronization primitives for writing multithreaded programs.

The Thread class is used to represent a separate thread of control. A new thread can be created as follows:   

`Thread(group=None, target=None, name=None, args=(), kwargs={})`   This creates a new `Thread` instance.

A Thread instance `t` supports the following methods and attributes:   

- `t.start()`   Starts the thread by invoking the `run()` method in a separate thread of control.
- `t.run()`   This method is called when the thread starts.
- `t.join([timeout])` Waits until the thread terminates or a timeout occurs.
- `t.daemon`   The thread’s Boolean daemonic flag.

## `Timer` Objects

A `Timer` object is used to execute a function at some later time.   

`Timer(interval, func [, args [, kwargs]])`   Creates a timer object that runs the function `func` after `interval` seconds have elapsed.

A Timer object, `t`, has the following methods:   

- `t.start()`   Starts the timer.
- `t.cancel()`   Cancels the timer if the function has not executed yet.

## `Lock` Objects

A *primitive lock* (or mutual exclusion lock) is a synchronization primitive that’s in either a “locked” or “unlocked” state. Two methods, `acquire()` and `release()`, are used to change the state of the lock.

A new `Lock` instance is created using the following constructor:   

`Lock()`   Creates a new Lock object that’s initially unlocked.   

A `Lock` instance, `lock`, supports the following methods:   

- `lock.acquire([blocking ])`   Acquires the lock, blocking until the lock is released if necessary.
- `lock.release()`   Releases a lock.

`RLock` A reentrant lock is a synchronization primitive that’s similar to a Lock object, but it can be acquired multiple times by the same thread. This allows the thread owning the lock to perform nested `acquire()` and `release()` operations. In this case, only the outermost `release()` operation resets the lock to its unlocked state.

A new RLock object is created using the following constructor:   

`RLock()`   Creates a new reentrant lock object.

- `rlock.acquire([blocking ])`   Acquires the lock, blocking until the lock is released if necessary.
- `rlock.release()`   Releases a lock by decrementing its recursion level.

## Semaphore and Bounded Semaphore

A *semaphore* is a synchronization primitive based on a counter that’s decremented by each `acquire()` call and incremented by each `release()` call.

`Semaphore([value])`   Creates a new semaphore.

A `Semaphore` instance, `s`, supports the following methods:   

- `s.acquire([blocking])`   Acquires the semaphore.
- `s.release()`   Releases a semaphore by incrementing the internal counter by 1.

`BoundedSemaphore([value])`   Creates a new semaphore.

A `BoundedSemaphore` works exactly like a Semaphore except the number of `release()` operations cannot exceed the number of `acquire()` operations.

## Events

*Events* are used to communicate between threads.

An `Event` instance manages an internal flag that can be set to true with the `set()` method and reset to false with the `clear()` method. The `wait()` method blocks until the flag is true.

`Event()`   Creates a new `Event` instance with the internal flag set to false.

- `e.set()`   Sets the internal flag to true.
- `e.clear()`   Resets the internal flag to false.   
- `e.wait([timeout])`   Blocks until the internal flag is true

## Condition Variables

A *condition variable* is a synchronization primitive, built on top of another lock that’s used when a thread is interested in a particular change of state or event occurring.

`Condition([lock])`   Creates a new condition variable.

A condition variable, `cv`, supports the following methods:   

- `cv.acquire(*args)`   Acquires the underlying lock.
- `cv.release()`   Releases the underlying lock.
- `cv.wait([timeout])`   Waits until notified or until a timeout occurs
- `cv.notify([n])`   Wakes up one or more threads waiting on this condition variable.

## Thread Termination and Suspension

Threads do not have any methods for forceful termination or suspension. This omission is by design and due to the intrinsic complexity of writing threaded programs. For example, if a thread has acquired a lock, forcefully terminating or suspending it before it is able to release the lock may cause the entire application to deadlock.

## Utility Functions

- `current_thread()`   Returns the `Thread` object corresponding to the caller’s thread of control.   
- `enumerate()`   Returns a list of all currently active `Thread` objects.


# 20.5 `queue`, `Queue`

The `queue` module (named `Queue` in Python 2) implements various multiproducer, multiconsumer queues that can be used to safely exchange information between multiple threads of execution.

`Queue([maxsize])`   Creates a FIFO (first-in first-out) queue

`LifoQueue([maxsize])`   Creates a LIFO (last-in, first-out) queue (also known as a stack).

`PriorityQueue([maxsize])`   Creates a priority queue in which items are ordered from lowest to highest priority.

An instance `q` of any of the queue classes has the following methods:   

- `q.qsize()`   Returns the approximate size of the queue.
- `q.put(item [, block [, timeout]])`   Puts item into the queue.
- `q.get([block [, timeout]])`   Removes and returns an item from the queue.
- `q.join()`   Blocks until all items on the queue have been removed and processed.


# 20.6 Coroutines and Microthreading

A common use of this technique is in programs that need to manage a large collection of open files or sockets. For example, a network server that wants to simultaneously manage 1,000 client connections.

The underlying concept that drives this programming technique is the fact that the yield statement in a generator or coroutine function suspends the execution of the function until it is later resumed with a `next()` or `send()` operation. This makes it possible to cooperatively multitask between a set of generator functions using a scheduler loop.


# Navigation

[Table of Contents](README.md)

Prev: [19. Operating System Services](19-operating-system-services.md)

Next: [21. Network Programming and Sockets](21-network-programming-sockets.md)

