<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [13.1 `atexit`](#131-atexit)
- [13.2 `copy`](#132-copy)
- [13.3 `gc`](#133-gc)
- [13.4 `inspect`](#134-inspect)
- [13.5 `marshal`](#135-marshal)
- [13.6 `pickle`](#136-pickle)
- [13.7 `sys`](#137-sys)
  - [Variables](#variables)
  - [Functions](#functions)
- [13.8 `traceback`](#138-traceback)
- [13.9 `types`](#139-types)
- [13.10 `warnings`](#1310-warnings)
- [13.11 `weakref`](#1311-weakref)
- [Navigation](#navigation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 13.1 `atexit`

The `atexit` module is used to register functions to execute when the Python interpreter exits. A single function is provided:

```python
register(func [,args [,kwargs]])
```

Upon exit, functions are invoked in reverse order of registration (the most recently added exit function is invoked first).


# 13.2 `copy`

The copy module provides functions for making shallow and deep copies of compound objects, including lists, tuples, dictionaries, and instances of user-defined objects.

```python
'''
Makes a shallow copy of x by reating a new compound object 
and duplicating the members of x by reference.
'''
copy(x)

'''
Makes a deep copy of x by creating a new compound object 
and recursively duplicating all the members of x.
visit is an optional dictionary that’s used to keep track of visited
objects in order to detect and avoid cycles in recursively defined data structures.
'''
deepcopy(x [, visit])
```

A class can implement customized copy methods by implementing the methods `__copy__(self)` and `__deepcopy__(self, visit)`.


# 13.3 `gc`

The `gc` module provides an interface for controlling the garbage collector used to collect cycles in objects such as lists, tuples, dictionaries, and instances.

The garbage collector uses a **three level generational scheme** in which objects that survive the initial garbage-collection step are placed onto lists of objects that are checked less frequently.

```python
# Runs a full garbage
collect([generation])

# Disable and enable garbage collection
disable()
enable()

'''
A variable containing a read-only list of user-defined instances that are no longer in use,
but which cannot be garbage collected because they are involved in a reference cycle
and they define a _ _del_ _() method
'''
garbage

'''
Returns a tuple (count0, count1, count2) containing the number of objects currently
in each generation.
'''
get_count()

# Returns the debugging flags currently set
get_debug()

# Returns a list of all objects being tracked by the garbage collector
get_objects()

# Returns a list of all objects that directly refer to the objects obj1, obj2, and so on
get_referrers(obj1, obj2, ...)

# Returns a list of objects that the objects obj1, obj2, and so on refer to
get_referents(obj1, obj2, ...)

# Returns the current collection threshold as a tuple.
get_threshold()

isenabled()

# Sets the garbage-collection debugging flags
set_debug(flags)

# Sets the collection frequency of garbage collection
set_threshold(threshold0 [, threshold1[, threshold2]])
```

Notes

- Circular references involving objects with a _ _del_ _() method are not garbage-collected and are placed on the list gc.garbage (uncollectable objects). 
- The functions get_referrers() and get_referents() only apply to objects that support garbage collection. In addition, these functions are only intended for debugging.


# 13.4 `inspect`

The `inspect` module is used to gather information about live Python objects such as attributes, documentation strings, source code, stack frames, and so on.

```python
'''
Cleans up a documentation string doc by changing all tabs into whitespace and removing
indentation that might have been inserted to make the docstring line up with other
statements inside a function or method
'''
cleandoc(doc)

# Returns the frame object corresponding to the caller’s stack frame.
currentframe()

# Produces a nicely formatted string representing the values returned by getargspec()
formatargspec(args [, varags [, varkw [, defaults]]])

# Produces a nicely formatted string representing the values returned by getargvalues()
formatargvalues(args [, varargs [, varkw [, locals]]])

# Given a function, func, returns a named tuple ArgSpec(args, varargs, varkw, defaults)
getargspec(func)

# Returns the values of arguments supplied to a function with execution frame frame.
getargvalues(frame)
 
# Given a list of related classes, classes, this function organizes the classes into a hierarchy based on inheritance. 
getclasstree(classes [, unique])

# Returns a string consisting of comments that immediately precede the definition of object in Python source code.
getcomments(object)

# Return the documentation string for object
getdoc(object)
 
# Returns the name of the file in which object was defined.
getfile(object)

 
# Returns a named tuple Traceback(filename, lineno, function, code_context, index) containing information about the frame object frame. filename and line specify a source code location. 
getframeinfo(frame [, context])

# Returns all of the members of object.
getmembers(object [, predicate])

# Returns the module in which object was defined.
getmodule(object)

# Returns information about how Python would interpret the file path.
getmoduleinfo(path)

# Return a tuple of classes that represent the method-resolution ordering used to resolve methods in class cls.
getmro(cls)

# Returns a list of frame records for frame and all outer frames.
getouterframes(frame [, context])

# Returns the name of the Python source file in which object was defined.
getsourcefile(object)

# Returns True if object is an abstract base class.
isabstract(object)

isbuiltin(object)
isclass(object)
iscode(object)
isdatadescriptor(object)
isfunction(object)
isgenerator(object)
ismethod(object)

# Returns a list of frame records corresponding to the stack of the caller.
stack([context])

# Returns a list of frame records for the stack between the current frame and the frame in which the current exception was raised. 
trace([context])
```


# 13.5 `marshal`

The marshal module is used to serialize Python objects in an “undocumented” Python-specific data format.

```python
# Writes the object value to the open file object file.
dump(value, file [, version])

# Reads and returns the next value from the open file object file.
load(file)
```

Only `None`, integers, long integers, floats, complex numbers, strings, Unicode strings, tuples, lists, dictionaries, and code objects are supported. Lists, tuples, and dictionaries can only contain supported objects. Class instances and recursive references in lists, tuples, and dictionaries are not supported.


# 13.6 `pickle`

The pickle module is used to serialize Python objects into a stream of bytes suitable for storing in a file, transferring across a network, or placing in a database.

```python
# Dumps a pickled representation of object to the file object file. protocol specifies the output format of the data
dump(object, file [, protocol ])

# Loads and returns a pickled representation of an object from the file object file.
load(file)
```

When loading, it is not necessary to specify the protocol or any information about the type of object being loaded. That information is saved as part of the pickle data format itself.

When working with complicated data structures involving cycles or shared references, using `dump()` and `load()` can be problematic because they don’t maintain any internal state about objects that have already been pickled or restored. This can result in output files that are excessively large and that don’t properly restore the relationship between objects when loaded. An alternative approach is to use `Pickler` and `Unpickler` objects.


# 13.7 `sys`

The sys module contains variables and functions that pertain to the operation of the interpreter and its environment.

## Variables

1. `api_version`
2. `argv`
3. `builtin_module_names`
4. `byteorder`
5. `__excepthook__`
6. `exeutable`
7. `flags`
8. `float_info`
9. `hexversion`
10. `last_type`, `laste_value`, `last_traceback`
11. `maxint`, `maxsize`, `maxunicode`
12. `modules`
13. `path`, `platform`
14. `stdin`, `stdout`, `stderr`

## Functions

1. `_clear_type_cache()`
2. `_current_frames()`
3. `displayhook([value])`, `excepthook(type, value, traceback)`
4. `exc_clear()`, `exc_info()`
5. `exit([n])`
6. `getdefaultencoding()`, `getsystemencoding()`
7. `_getgrame([depth])`
8. `getprofile()`
9. `getcursionlimit()`, `getrefcount()`, `getsizeof(object, [default])`
10. `gettrace()`


# 13.8 `traceback`

The `traceback` module is used to gather and print stack traces of a program after an exception has occurred. The main use of this module is in code that needs to report errors in a non-standard way.

1. `print_tb(traceback, [, limit [, file]])`, `extract_tb(traceback [, limit])`, `format_tb(traceback [, limit])`
2. `print_exc([limit [, file]])`, ...
3. `print_stack([frame [, limit [, file]]])`, ...


# 13.9 `types` 

The `types` module defines names for the built-in types that correspond to functions, modules, generators, stack frames, and other program elements.

- `FunctionType(code, globals [, name [, defarags [, closure]]])` Creates a new function object.
- `CodeType(argcount, nlocals, stacksize, flags, codestring, constants, names, varnames, filename, name, firstlineno, lnotab [, freevars [, cellvars]])` Creates a new code object.
- `MethodType(function, instance, class)` Creates a new bound instance method.
- `ModuleType(name [, doc])` Creates a new module object.


# 13.10 `warnings`

The `warnings` module provides functions to issue and filter warning messages.

Like exceptions, warnings are organized into a class hierarchy that describes general categories of warnings.

- Warning
- UserWarning
- DeprecationWarning
- SyntaxWarning
- RuntimeWarning
- FutureWarning

Warnings are issued using the `warn()` function.

```python
warnings.warn("feature X is deprecated.")
```

If desired, `warnings` can be filtered. The filtering process can be used to alter the output behavior of warning messages, to ignore warnings, or to turn warnings into exceptions. The `filterwarnings()` function is used to add a filter for a specific type of warning.


# 13.11 `weakref`

The `weakref` module is used to provide support for weak references. A weak reference  provides a way of referring to an object without increasing its reference count. This can be useful in certain kinds of applications that must manage objects in unusual ways

A weak reference is created using the `weakref.ref()` function as follows:

```python
class A: pass
a = A()
ar = weakref.ref(a)
print ar
```
Once a weak reference is created, the original object can be obtained from the weak reference by simply calling it as a function with no arguments. If the underlying object still exists, it will be returned. Otherwise, `None` is returned to indicate that the original object no longer exists.

Only class instances, functions, methods, sets, frozen sets, files, generators, type objects, and certain object types defined in library modules (for example, sockets, arrays, and regular expression patterns) support weak references. Built-in functions and most built-in types such as lists, dictionaries, strings, and numbers cannot be used.


# Navigation

[Table of Contents](README.md)

Prev: [12. Build-In Functions and Exceptions](12-built-in-functions-and-exceptions.md)

Next: [14. Mathematics](14-mathematics.md)
