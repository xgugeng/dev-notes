<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [19.1 `Commands`](#191-commands)
- [19.2 `ConfigParser`, `configparser`](#192-configparser-configparser)
- [19.3 `datetime`](#193-datetime)
  - [`date` Objects](#date-objects)
  - [`time` Objects](#time-objects)
  - [`datetime` Objects](#datetime-objects)
  - [`timedelta` Objects](#timedelta-objects)
  - [`tzinfo` Objects](#tzinfo-objects)
- [19.4 `errno`](#194-errno)
- [19.5 `fcntl`](#195-fcntl)
- [19.6 `io`](#196-io)
  - [Base I/O Interface](#base-io-interface)
  - [RAW I/O](#raw-io)
  - [Buffered Binary I/O](#buffered-binary-io)
  - [Text I/O](#text-io)
  - [The `open` Function](#the-open-function)
  - [Abstract Base Classes](#abstract-base-classes)
- [19.7 `logging`](#197-logging)
  - [Log Levels](#log-levels)
  - [Basic Configuration](#basic-configuration)
  - [`Logger` Objects](#logger-objects)
    - [Filtering Log Messages](#filtering-log-messages)
    - [Message Propagation and Hierarchical Loggers](#message-propagation-and-hierarchical-loggers)
    - [Message Handling](#message-handling)
  - [Hander Objects](#hander-objects)
    - [Handler Configuration](#handler-configuration)
  - [Message Formatting](#message-formatting)
    - [Adding Extra Context to Messages](#adding-extra-context-to-messages)
  - [Miscellaneous Utility Functions](#miscellaneous-utility-functions)
  - [Logging Configuration](#logging-configuration)
- [19.8 `mmap`](#198-mmap)
- [19.9 `msvcrt`](#199-msvcrt)
- [19.10 `optparse`](#1910-optparse)
- [19.11 `os`](#1911-os)
  - [File Creation and File Descriptors](#file-creation-and-file-descriptors)
  - [File and Directories](#file-and-directories)
  - [Process Management](#process-management)
- [19.12 `os.path`](#1912-ospath)
- [19.13 `signal`](#1913-signal)
- [19.14 `subprocess`](#1914-subprocess)
- [19.15 `time`](#1915-time)
- [19.16 `winreg`](#1916-winreg)
- [Navigation](#navigation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

Most of Python’s operating system modules are based on POSIX interfaces.


# 19.1 `Commands`

The `commands` module is used to execute simple system commands specified as a string and return their output as a string.

`getoutput(cmd)` Executes `cmd` in a shell and returns a string containing both the standard output and standard error streams of the command.


# 19.2 `ConfigParser`, `configparser`


The `ConfigParser` module (called `configparser` in Python 3) is used to read `.ini` format configuration files based on the Windows INI format.

`ConfigParser([defaults [, dict_type]])` Creates a new `ConfigParser` instance. An instance `c` of `ConfigParser` has the following operations:

- c.get(section, option [, raw [, vars]])   Returns the value of option option from section section as a string.
- `c.getboolean(section, option)` Returns the value of `option` from `section`section converted to Boolean value.
- `c.has_option(section, option)` Returns `True` if section section has an option named `option`. 
- `c.has_section(section)` Returns `True` if there is a section named `section`.   
- `c.items(section [, raw [, vars]])`   Returns a list of `(option, value)` pairs from section `section`.
- `c.options(section)`   Returns a list of all options in section `section`.
- `c.read(filenames)`   Reads configuration options from a list of `filenames` and stores them.
- `c.write(file)`   Writes all of the currently held configuration data to `file`.


# 19.3 `datetime`

The `datetime` module provides a variety of classes for representing and manipulating dates and times.

## `date` Objects

A `date` object represents a simple date consisting of a year, month, and day.

- `date(year, month, day)`   Creates a new `date` object.
- `date.today()`   A class method that returns a date object corresponding to the current date.
- `date.fromtimestamp(timestamp)`   A class method `that` returns a date object corresponding to the timestamp `timestamp`. `timestamp` is a value returned by the `time.time()` function.

An instance, `d`, of `date` has read-only attributes `d.year, d.month, and d.day` and additionally provides the following methods:   

- `d.ctime()`   Returns a string representing the date in the same format as normally used by the `time.ctime()` function.
- `d.strftime(format)`   Returns a string representing the date formatted according to the same rules as the `time.strftime()` function.

## `time` Objects

`time` objects are used to represent a time in hours, minutes, seconds, and microseconds.

`time(hour [, minute [, second [, microsecond [, tzinfo]]]])`   Creates a time object representing a time.

The following class `time` describe the range of allowed values and resolution of `time` instances:

- `t.strftime(format)`   Returns a string formatted according to the same rules as the `time.strftime()` function in the `time` module.

## `datetime` Objects

`datetime` objects are used to represent dates and times together.

- `datetime(year, month, day [, hour [, minute [, second [, microsecond [, tzinfo]]]]])`   Creates a new datetime object that combines all the features of date and `time` objects.
- `datetime.fromtimestamp(timestamp [, tz])`   A class method that creates a `datetime` object from a timestamp returned by the `time.time()` function.
- `datetime.now([tz])`   A class method that creates a `datetime` object from the current local date and time.
- `datetime.strptime(datestring, format)`   A class method that creates a `datetime` object by parsing the date string in `datestring` according to the date format in `format`.

A instance, `d`, of a `datetime` object has same methods as `date` and `time` objects combined:

- `d.date()`   Returns a date object with the same date.
- `d.time()`   Returns a time object with the same time.

## `timedelta` Objects

`timedelta` objects represent the difference between two dates or times.

`timedelta([days [, seconds [, microseconds [, milliseconds [, minutes [, hours [, weeks ]]]]]]])`   Creates a `timedelta` object that represents the difference between two dates and times.

## `tzinfo` Objects

Individual time zones are created by inheriting from tzinfo and implementing the following methods:   

- `tz.dst(dt)`   Returns a timedelta object representing daylight savings time adjustments, if applicable.


# 19.4 `errno`

The `errno` module defines symbolic names for the integer error codes returned by various operating system calls, especially those found in the `os` and `socket` modules. These codes are typically found in the errno attribute of an `OSError` or `IOError` exception. The `os.strerror()` function can be used to translate an error code into a string error message.


# 19.5 `fcntl`

The `fcntl` module performs file and I/O control on UNIX file descriptors. File descriptors can be obtained using the `fileno()` method of a file or socket object.

- `fcntl(fd, cmd [, arg])` Performs a command, cmd, on an open file descriptor, `fd`. `cmd` is an integer command code.
- `flock(fd, op)`   Performs a lock operation, `op`, on the file descriptor `fd`.

# 19.6 `io`

The `io` module implements classes for various forms of I/O as well as the built-in open() function that is used in Python 3. The module is also available for use in Python 2.6.

## Base I/O Interface

The `io` module defines a basic I/O programming interface that all file-like objects implement. This interface is defined by a base class `IOBase`.

## RAW I/O

The lowest level of the I/O system is related to direct I/O involving raw bytes. The core object for this is `FileIO`, which provides a fairly direct interface to low-level system calls such as `read()` and `write()`.

`FileIO(name [, mode [, closefd]])`   A class for performing raw low-level I/O on a file or system file descriptor.

## Buffered Binary I/O

The buffered I/O layer contains a collection of file objects that read and write raw binary data, but with in-memory buffering. As input, these objects all require a file object that implements raw I/O such as the `FileIO` object in the previous section. All of the classes in this section inherit from `BufferedIOBase`.   

- `BufferedReader(raw [, buffer_size])`   A class for buffered binary reading on a raw file specified in `raw`.
- `BufferedWriter(raw [, buffer_size [, max_buffer_size]])`   A class for buffered binary writing on a raw file specified in `raw`.
- `BufferedRWPair(reader, writer [, buffer_size [, max_buffer_size]])`   A class for buffered binary reading and writing on a pair of raw I/O streams.
- `BufferedRandom(raw [, buffer_size [, max_buffer_size]])`   A class for buffered binary reading and writing on a raw I/O stream that supports random access (e.g., seeking).
- `BytesIO([bytes])`   An in-memory file that implements the functionality of a buffered I/O stream.

## Text I/O

The text I/O layer is used to process line-oriented character data. The classes defined in this section build upon buffered I/O streams and add line-oriented processing as well as Unicode character encoding and decoding. All of the classes here inherit from `TextIOBase`.

`TextIOWrapper(buffered [, encoding [, errors [, newline [, line_buffering]]]])`  A class for a buffered text stream.

`StringIO([initial [, encoding [, errors [, newline]]]])`   An in-memory file object with the same behavior as a `TextIOWrapper`.

## The `open` Function

The `io` module defines the following `open()` function, which is the same as the built-in `open()` function in Python 3.   

`open(file [, mode [, buffering [, encoding [, errors [, newline [, closefd]]]]]])` Opens file and returns an appropriate I/O object.

## Abstract Base Classes

The `io` module defines the following abstract base classes that can be used for type checking and defining new I/O classes:

- `IOBase`
- `RawIOBase`
- `BufferedIOBase`
- `TextIOBase`


# 19.7 `logging`

The `logging` module provides a flexible facility for applications to log events, errors, warnings, and debugging information.

## Log Levels

Each message consists of some text along with an associated level that indicates its severity.

These different levels are the basis for various functions and methods throughout the logging module.

## Basic Configuration

Before using any other functions in the `logging` module, you should first perform some basic configuration of a special object known as the root logger. The root logger is responsible for managing the default behavior of log messages including the logging level, output destination, message format, and other basic details.

`basicConfig([**kwargs])`   Performs basic configuration of the root logger.

## `Logger` Objects

To create a new Logger object, you use the following function: 
  
`getLogger([logname])`   Returns a Logger instance associated with the name logname.

Internally, `getLogger()` keeps a cache of the `Logger` instances along with their associated names. If another part of the program requests a logger with the same name, the previously created instance is returned.

There are a few additional methods for issuing log messages on a `Logger` instance `log`.

- `log.exception(fmt [, *args ])`   Issues a message at the `ERROR` level but adds exception information from the current exception being handled.
- `log.log(level, fmt [, *args [, exc_info [, extra]]])`   Issues a logging message at the level specified by `level`.
- `log.findCaller()`   Returns a tuple `(filename, lineno, funcname)` corresponding to the caller’s source filename, line number, and function name.

### Filtering Log Messages

Each `Logger` object `log` has an internal level and filtering mechanism that determines which log messages get handled. 

`log.addFilter(filt)` Adds a filter object, `filt`, to the logger.

`Filter(logname)`   Creates a filter that only allows log messages from `logname` or its children to pass through.

Custom filters can be created by subclassing `Filter` and implementing the method `filter(record`) that receives as input a record containing information about a logging message. As output, `True` or `False` is returned depending on whether or not the message should be handled.

### Message Propagation and Hierarchical Loggers

In advanced logging applications, `Logger` objects can be organized into a hierarchy. This is done by giving a logger object a name such as 'app.net.client'. Here, there are actually three different Logger objects called 'app', 'app.net', and 'app.net.client'. When a message is issued on any of the loggers and it successfully passes that logger’s filter, it propagates to and is handled by all of the parents. 

The following attributes and methods of a Logger object log control this propagation.   

`log.propagate`   A Boolean flag that indicates whether or not messages propagate to the parent logger.

### Message Handling

Normally, messages are handled by the root logger. However, any `Logger` object can have special handlers added to it that receive and process log messages. This is done using these methods of a `Logger` instance `log`. 

`log.addHandler(handler)`   Adds a `Handler` object to the logger.

## Hander Objects

The `logging` module provides a collection of pre-built handlers that can process log messages in various in ways. These handlers are added to Logger objects using their `addHandler()` method.

- `handlers.DatagramHandler(host,port)`   Sends log messages to a UDP server located on the given `host` and `port`.
- `handlers.HTTPHandler(host, url [, method])`   Uploads log messages to an HTTP server using HTTP GET or POST methods.
- `handlers.MemoryHandler(capacity [, flushLevel [, target]])`   This handler is used to collect log messages in memory and to flush them to another handler, `target`, periodically.
- `handlers.SocketHandler(host, port)`   Sends log messages to a remote host using a TCP socket connection.
- `FileHandler(filename [, mode [, encoding [, delay]]])`   Writes log messages to the file `filename`.

### Handler Configuration

Each `Handler` object `h` can be configured with its own level and filtering. The following methods are used to do this:   

- `h.setLevel(level)` Sets the threshold of messages to be handled.
- `h.flush()`   Flushes all logging output.   
- `h.close()`   Closes the handler.
- `h.addFilter(filt)`   Adds a Filter object, `filt`, to the handler. See the `addFilter()` method of Logger objects for more information.

## Message Formatting

`Formatter([fmt [, datefmt]])`   Creates a new Formatter object.

To take effect, `Formatter` objects must be attached to handler objects. This is done using the `h.setFormatter()` method of a Handler instance `h`.

### Adding Extra Context to Messages

In certain applications, it is useful to add additional context information to log messages. This extra information can be provided in one of two ways. First, all of the basic logging operations (e.g., `log.critical()`, `log.warning()`, etc.) have a keyword parameter `extra` that is used to supply a dictionary of additional fields for use in message format strings. These fields are merged in with the context data previously described for `Formatter` objects.

`LogAdapter(log [, extra])`   Creates a wrapper around a Logger object log.


## Miscellaneous Utility Functions

The following functions in logging control a few other aspects of logging: 
  
- `disable(level)`   Globally disables all logging messages below the level specified in `level`.
- `shutdown()`   Shuts down all logging objects, flushing output if necessary.

## Logging Configuration

Setting an application to use the `logging` module typically involves the following basic steps:   

1. Use `getLogger(`) to create various Logger objects. Set parameters such as the level, as appropriate. 
2. Create `Handler` objects by instantiating one of the various types of handlers (`FileHandler`, `StreamHandler`, `SocketHandler`, and so on) and set an appropriate level. 
3. Create message `Formatter` objects and attach them to the `Handler` objects using the `setFormatter()` method. 
4. Attach the `Handler` objects to the `Logger` objects using the `addHandler()` method.

`fileConfig(filename [, defaults [, disable_existing_loggers]])`   Reads the logging configuration from the configuration file filename.


# 19.8 `mmap`

The `mmap` module provides support for a memory-mapped file object.

A memory-mapping file is created by the `mmap()` function, which is slightly different on UNIX and Windows.   

`mmap(fileno, length [, flags, [prot [,access [, offset]]]])`   (UNIX). Returns an `mmap` object that maps `length` bytes from the file with an integer file descriptor, `fileno`.

A memory-mapped file object, `m`, supports the following methods.   

- `m.close()`   Closes the file. Subsequent operations will result in an exception.
- m.find(string[, start])   Returns the index of the first occurrence of string.
- m.flush([offset, size])   Flushes modifications of the in-memory copy back to the file system.
- `m.move(dst,src,count)`   Copies count bytes starting at index `src` to the destination index `dst`.
- `m.read(n)`   Reads up to `n` bytes from the current file position and returns the data as a string.
- `m.seek(pos[, whence])`   Sets the file position to a new value.
-` m.write(string)`   Writes a string of bytes to the file at the current file pointer.


# 19.9 `msvcrt`

The `msvcrt` module provides access to a number of useful functions in the Microsoft Visual C runtime library. **This module is available only on Windows**.

- `getch()`   Reads a keypress and returns the resulting character.
- `heapmin()`   Forces the internal Python memory manager to return unused blocks to the operating system.
- `locking(fd, mode, nbytes)`   Locks part of a file, given a file descriptor from the C runtime.
- `open_osfhandle(handle, flags)`   Creates a C runtime file descriptor from the file handle `handle`.
- `putch(char)`   Prints the character `char` to the console without buffering.


# 19.10 `optparse`

The `optparse` module provides high-level support for processing UNIX-style command-line options supplied in `sys.argv`.

`OptionParser([**args])`   Creates a new command option parser and returns an `OptionParser` instance.

An instance, `p`, of OptionParser supports the following methods:   

- `p.add_option(name1, ..., nameN [, **parms])`   Adds a new option to `p`.
- `p.enable_interspersed_args()`   Allows the mixing of options with positional arguments.
- `p.parse_args([arglist])`   Parses command-line options and returns a tuple `(options, args)` where options is an object containing the values of all the options and args is a list of all the remaining positional arguments left over.
- `p.set_defaults(dest=value, ... dest=value)`   Sets the default values of particular option destinations.


# 19.11 `os`

The `os` module provides a portable interface to common operating-system services. It does this by searching for an OS-dependent built-in module such as `nt` or `posix` and exporting the functions and data as found there.

The following general-purpose variables are defined:   

- `environ`   A mapping object representing the current environment variables. Changes to the mapping are reflected in the current environment.
- `linesep`   The string used to separate lines on the current platform.
- `path`   The OS-dependent standard module for pathname operations.
- `chdir(path)`   Changes the current working directory to `path`.
- `getcwd()`   Returns a string with the current working directory.
-` getlogin()`   Returns the user name associated with the effective user ID (UNIX).
- `getpid()`   Returns the real process ID of the current process (UNIX and Windows).
- `putenv(varname, value)`   Sets environment variable `varname` to `value`.
- `uname()`   Returns a tuple of strings `(sysname, nodename, release, version, machine)` identifying the system type (UNIX).
- `umask(mask)`   Sets the current numeric umask and returns the previous umask.

## File Creation and File Descriptors

- `close(fd)`   Closes the file descriptor fd previously returned by `open()` or `pipe()`.
- `dup(fd)`   Duplicates file descriptor `fd`.
- `fchown(fd, uid, gid)`   Changes the owner and group ID of the file associated with `fd` to `uid` and `gid`.
- `fdopen(fd [, mode [, bufsize]])`   Creates an open file object connected to file descriptor `fd`.
- `fstat(fd)`   Returns the status for file descriptor `fd`.
- `fsync(fd)`   Forces any unwritten data on `fd` to be written to disk.
- `ftruncate(fd, length)`   Truncates the file corresponding to file descriptor `fd` so that it’s at most `length` bytes in size (UNIX).
- `lseek(fd, pos, how)`   Sets the current position of file descriptor `fd` to position `pos`.
- `open(file [, flags [, mode]])`   Opens the file `file`.
- `pipe()`   Creates a pipe that can be used to establish unidirectional communication with another process
- `read(fd, n)`   Reads at most `n` bytes from file descriptor `fd`.
- `write(fd, str)`   Writes the byte string `str` to file descriptor `fd`.

## File and Directories

- `access(path, accessmode)`   Checks read/write/execute permissions for this process to access the file `path`.
- `chflags(path, flags)`   Changes the file `flags` on `path`.
- `chmod(path, mode)`   Changes the mode of `path`.
- `chown(path, uid, gid)`   Changes the owner and group ID of `path` to the numeric `uid` and `gid`.
- `link(src, dst)`   Creates a hard link named `dst` that points to `src` (UNIX).
- `major(devicenum)`   Returns the major device number from a raw device number `devicenum` created by `makedev()`.
- `mkdir(path [, mode])`   Creates a directory named `path` with numeric mode `mode`.
- `readlink(path)`   Returns a string representing the path to which a symbolic link, `path`, points (UNIX).
- `remove(path)`   Removes the file `path`.
- `rename(src, dst)`   Renames the file or directory `src` to `dst`.
- `stat(path)`   Performs a `stat()` system call on the given `path` to extract information about a file.
- `symlink(src, dst)`   Creates a symbolic link named dst that points to src.
- `unlink(path)`   Removes the file `path`. Same as `remove()`.   
- `utime(path, (atime, mtime))`   Sets the access and modified time of the file to the given values.

## Process Management

- `abort()`   Generates a `SIGABRT` signal that’s sent to the calling process.
- `execv(path, args)`   Executes the program `path` with the argument list `args`, replacing the current process (that is, the Python interpreter).
- `_exit(n)`   Exits immediately to the system with status `n`, without performing any cleanup actions.
- `fork()`   Creates a child process.
- `kill(pid, sig)`   Sends the process `pid` the signal `sig`.
- `popen(command [, mode [, bufsize]])`   Opens a pipe to or from a `command`.
- `spawnv(mode, path, args)`   Executes the program path in a new process, passing the arguments specified in `args` as command-line parameters.
- `startfile(path [, operation])`   Launches the application associated with the file `path`.
- `system(command)`   Executes `command` (a string) in a subshell.
- `times()`   Returns a 5-tuple of floating-point numbers indicating accumulated times in seconds.
- `waitpid(pid, options)`   Waits for a change in the state of a child process given by process ID pid and returns a tuple containing its process ID and exit status indication, encoded as for `wait()`.


# 19.12 `os.path`

The `os.path` module is used to manipulate pathnames in a portable manner. It’s imported by the `os` module.

- `basename(path)`   Returns the base name of path name `path`. For example, basename('/usr/local/python') returns 'python'.
- `dirname(path)`   Returns the directory name of path name `path`. For example, dirname('/usr/local/ python') returns '/usr/local'.
- `exists(path)`   Returns `True` if `path` refers to an existing path.
- `getctime(path)`   Returns the time of last modification on UNIX and the time of creation on Windows.
- `isfile(path)`   Returns `True` if `path` is a regular file.
- `join(path1 [, path2 [, ...]])`   Intelligently joins one or more path components into a pathname. For example, `join('home', 'beazley', 'Python')` returns 'home/beazley/Python'.
- `normcase(path)`   Normalizes the case of a path name.
- `split(path)`   Splits `path` into a pair `(head, tail)`, where `tail` is the last pathname component and `head` is everything leading up to that. For example, '/home/user/foo' gets split into ('/home/ user', 'foo'). This tuple is the same as would be returned by `(dirname(), basename())`.


# 19.13 `signal`

The `signal` module is used to write signal handlers in Python. Signals usually correspond to asynchronous events that are sent to a program due to the expiration of a timer, arrival of incoming data, or some action performed by a user

- `getsignal(signalnum)`   Returns the signal handler for signal `signalnum`.
- `pause()`   Goes to sleep until the next signal is received (UNIX).
- `set_wakeup_fd(fd)`   Sets a file descriptor fd on which a '\0' byte will be written when a signal is received.
- `signal(signalnum, handler)`   Sets a signal handler for signal `signalnum` to the function `handler`.


# 19.14 `subprocess`

The `subprocess` module contains functions and objects that generalize the task of creating new processes, controlling input and output streams, and handling return codes. The module centralizes functionality contained in a variety of other modules such as `os`, `popen2`, and `commands`.

- `Popen(args, **parms)`   Executes a new command as a subprocess and returns a Popen object representing the new process. 
- `call(args, **parms)`   This function is exactly the same as `Popen()`, except that it simply executes the command and returns its status code instead (that is, it does not return a `Popen` object).

The `Popen` object p returned by `Popen()` has a variety of methods and attributes that can be used for interacting with the subprocess.   

- `p.communicate([input])`   Communicates with the child process by sending the data supplied in input to the standard input of the process
- `p.poll()`   Checks to see if p has terminated.
- `p.send_signal(signal)`   Sends a signal to the subprocess.
- `p.terminate()`   Terminates the subprocess by sending it a `SIGTERM` signal on UNIX or calling the Win32 API TerminateProcess function on Windows.   
- `p.wait()`   Waits for p to terminate and returns the return code.

As a general rule, it is better to supply the command line as a list of strings instead of a single string with a shell command (for example, ['wc','filename'] instead of 'wc filename'). On many systems, it is common for filenames to include funny characters and spaces.


# 19.15 `time`

The `time` module provides various time-related functions. In Python, time is measured as the number of seconds since the epoch. The `epoch` is the beginning of time (the point at which time = 0 seconds).

- `timezone`   The local (non-DST) time zone.
- `asctime([tuple])`   Converts a tuple representing a time as returned by `gmtime()` or `localtime()` to a string of the form 'Mon Jul 12 14:45:23 1999'.
- `ctime([secs])`   Converts a time expressed in seconds since the epoch to a string representing local time.
- `gmtime([secs])`   Converts a time expressed in seconds since the epoch to a time in UTC Coordinated Universal Time (a.k.a. Greenwich Mean Time).
- `localtime([secs])`   Returns a struct_time object as with gmtime(), but corresponding to the local time zone.
- `mktime(tuple)`   This function takes a struct_time object or tuple representing a time in the local time zone (in the same format as returned by `localtime()`) and returns a floating-point number representing the number of seconds since the epoch.
- `sleep(secs)`   Puts the current process to sleep for secs seconds. secs is a floating-point number.   
- `strftime(format [, tm])`   Converts a `struct_time` object `tm` representing a time as returned by `gmtime()` or `localtime()` to a string (for backwards compatibility, tm may also be a tuple representing a time value).
- `strptime(string [, format])`   Parses a string representing a time and returns a struct_time object as returned by `localtime()` or `gmtime()`.
- `time()`   Returns the current time as the number of seconds since the epoch in UTC (Coordinated Universal Time).


# 19.16 `winreg`

The `winreg` module (`_winreg` in Python 2) provides a low-level interface to the Windows registry.

- `CloseKey(key)`   Closes a previously opened registry key with handle `key`.
- `ConnectRegistry(computer_name, key)`   Returns a handle to a predefined registry key on another computer.
- `CreateKey(key, sub_key)`   Creates or opens a key and returns a handle.
- `DeleteKey(key, sub_key)`   Deletes `sub_key`.
- `EnumKey(key, index)`   Returns the name of a subkey by index.
- `FlushKey(key)`   Writes the attributes of key to the registry, forcing changes to disk.


# Navigation

[Table of Contents](README.md)

Prev: [18. File and Directory Handling](18-file-directory-handling.md)

Next: [20. Threads and Concurrenty](20-threads-concurrency.md)
