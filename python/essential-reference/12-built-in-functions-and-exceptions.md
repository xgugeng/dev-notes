<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [12.1 Built-in Functions and Types](#121-built-in-functions-and-types)
- [12.2 Built-In Exceptions](#122-built-in-exceptions)
  - [Exception Base Classes](#exception-base-classes)
  - [Exception Instances](#exception-instances)
  - [Predefined Exception Classes](#predefined-exception-classes)
- [12.3 Built-In Warnings](#123-built-in-warnings)
- [12.4 future_builtins](#124-future_builtins)
- [Navigation](#navigation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 12.1 Built-in Functions and Types

Although you don’t need to perform any extra imports to access these functions, they are contained in a module `__builtin__` in Python 2 and in a module `builtins` in Python 3.

```python
abs(x)

# Return True if all of the values in the interables s evaluates as True
all(s)

# Returns True if any of the values in the iterable s evaluate as True
any(s)

# Creates a printable representation of the object x just like the repr(), but only uses ASCII characters in the result
ascii(x)

# This is an abstract data type that is the superclass of all strings in Python 2 (str and unicode).
basestring

# Returns a string containing the binary representation of the integer x
bin(x)

# Type representing Boolean values True and False
bool([x])

# A type representing a mutable array of bytes
bytearray([x])

# An alternative calling convention for creating a bytearray instance from characters in a string s
bytearray(s ,encoding)

# A type representing an immutable array of bytes.
bytes([x])
bytes(s, encoding)

# Converts an integer value, x, into a one-character string
chr(x)

'''
This function creates a class method for the function func
It is typically only used inside class definitions where it is implicitly invoked by the @classmethod decorator
'''
classmethod(func)

'''
Compares x and y and returns a negative number if x < y, a positive number if x > y,
or 0 if x == y.
'''
cmp(x, y)

'''
Compiles string into a code object for use with exec() or eval(). 
string is a string containing valid Python code.
'''
compile(string, filename, kind [, flags [, dont_inherit]])

# Type representing a complex number with real and imaginary components
complex([real [, imag]])

# Deletes an attribute of an object. attr is a string
delattr(object, attr)

# Type representing a dictionary
dict([m]) or dict(key1 = value1, key2 = value2, ...)

# Returns a sorted list of attribute names
dir([object])

# Returns the quotient and remainder of long division as a tuple
divmod(a, b)

# if iter produces a, b, c, then enumerate(iter) produces (0,a), (1,b), (2,c).
enumerate(iter[, initial value)

# Evaluates an expression. expr is a string or a code object created by compile()
eval(expr [, globals [, locals]])

# Executes Python statements
exec(code [, global [, locals]])

'''
In Python 2, this creates a list consisting of the objects from iterable for which function evaluates to true.
In Python 3, the result is an iterator that produces this result.
'''
filter(function, iterable)

# Type representing a floating-point number
float([x])

# Converts value to a formatted string according to the format specification string in format_spec
format(value [, format_spec])

'''
Type representing an immutable set object populated with values taken from items that
must be an iterable.
'''
frozenset([items])

# Returns the value of a named attribute of an object.
getattr(object, name [,default])

# Returns the dictionary of the current module that represents the global namespace
globals()

# Returns True if name is the name of an attribute of object.
hasattr(object, name)

# Returns an integer hash value for an object (if possible)
hash(object)

# Calls the built-in help system during interactive sessions.
help([object])

# Creates a hexadecimal string from an integer x
hex(x)

# Returns the unique integer identity of object
id(object)

'''
In Python 2, this prints a prompt, reads a line of input, and processes it through eval()
(that is, it’s the same as eval(raw_input(prompt)). In Python 3, a prompt is printed
to standard output and a single line of input is read without any kind of evaluation or
modification.
'''
input([prompt]])

# Type representing an integer
int(x [,base])

'''
Returns True if object is an instance of classobj, is a subclass of classobj, or
belongs to an abstract base class classobj.
'''
isinstance(object, classobj)

'''
Returns True if class1 is a subclass of (derived from) class2 or if class1 is registered
with an abstract base class class2
'''
issubclass(class1, class2)

# Returns an iterator for producing items in object
iter(object [,sentinel])

# Returns the number of items contained in s
len(s)

# Type representing a list
list([items])

# Returns a dictionary corresponding to the local namespace of the caller
locals()

# Type representing long integers in Python 2
long([x [, base]])

'''
In Python 2, this applies function to every item of items and returns a list of results.
In Python 3, an iterator producing the same results is created.
'''
map(function, items, ...)

'''
For a single argument, s, this function returns the maximum value of the items in s,
which may be any iterable object. For multiple arguments, it returns the largest of the
arguments.
'''
max(s [, args, ...])
min(s [, args, ...])

# Returns the next item from the iterator s
next(s [, default])

# The base class for all objects in Python
object()

# Converts an integer, x, to an octal string.
oct(x)

# In Python 2, opens the file filename and returns a new file object
open(filename [, mode [, bufsize]])

# In Python 3, this opens the file filename and returns a file object.
open(filename [, mode [, bufsize [, encoding [, errors [, newline [, closefd]]]]]])

# Returns the integer ordinal value of a single character, c
ord(c)

# Returns x ** y
pow(x, y [, z])

# Python 3 function for printing a series of values
print(value, ... [, sep=separator, end=ending, file=outfile])

# Creates a property attribute for classes
property([fget [,fset [,fdel [,doc]]]])

# In Python 2, this creates a fully populated list of integers from start to stop
range([start,] stop [, step])

# Python 2 function that reads a line of input from standard input (sys.stdin) and returns it as a string
raw_input([prompt])

# Returns a string representation of object
repr(object)

# Creates a reverse iterator for sequence s
reversed(s)

'''
Rounds the result of rounding the floating-point number x to the closest multiple of 10
to the power minus n.
'''
round(x [, n])

# Creates a set populated with items taken from the iterable object items
set([items])

# Sets an attribute of an object.
setattr(object, name, value)

# Returns a slice object representing integers in the specified range
slice([start,] stop [, step])

# Creates a sorted list from items in iterable
sorted(iterable [, key=keyfunc [, reverse=reverseflag]])

'''
Creates a static method for use in classes
This function is implicitly invoked by the @staticmethod decorator
'''
staticmethod(func)

# Type representing a string
str([object])

# Computes the sum of a sequence of items taken from the iterable object items
sum(items [,initial])

# Returns an object that represents the superclasses of type
super(type [, object])

# Type representing a tuple
tuple([items])

# The base class of all types in Python
type(object)

# Creates a new type object
type(name, bases, dict)

# Converts the integer or long integer x, where 0 <= x <= 65535, to a single Unicode character
unichr(x)

# In Python 2, this converts string to a Unicode string
unicode(string [,encoding [,errors]])

# Returns the symbol table of object
vars([object])

# A type representing a range of integer values from start to stop that is not included
xrange([start,] stop [, step])

'''
In Python 2, returns a list of tuples where the nth tuple is (s1[n], s2[n], ...)
In Python 3, the result is an iterator that produces a sequence of tuples
'''
zip([s1 [, s2 [,..]]])
```

# 12.2 Built-In Exceptions

Built-in exceptions are contained in the `exceptions` module, which is always loaded prior to the execution of any program. Exceptions are defined as classes.

## Exception Base Classes

| Base Class       | Description                              |
| ---------------- | ---------------------------------------- |
| BaseException    | The root class for all exceptions        |
| Exception        | The base class for all program-related exceptions that includes all built-in exceptions |
| ArithmeticError  | The base class for arithmetic exceptions, including OverflowError |
| LookupError      | The base class for indexing and key errors, including IndexError and KeyError |
| EnvironmentError | The base class for errors that occur outside Python, including IOError and OSError |

The preceding exceptions are never raised explicitly. However, they can be used to catch certain classes of errors.

## Exception Instances

When an exception is raised, an instance of an exception class is created. Instances of an exception `e` have a few standard attributes that can be useful to inspect and/or manipulate in certain applications.

| Attribute         | Description                              |
| ----------------- | ---------------------------------------- |
| `e.args`          | The tuple of arguments supplied when raising the exception |
| `e.message`       | A string representing the error message  |
| `e._ _cause_ _`   | Previous exception when using explicit chained exceptions (Python 3 only). |
| `e.__context__`  | Previous exception for implicitly chained exceptions (Python 3 only) |
| `e.__traceback__` | Traceback object associated with the exception (Python 3 only) |


## Predefined Exception Classes

`AssertionError`
Failed assert statement.

`AttributeError`
Failed attribute reference or assignment.

`EOFError`
End of file. Generated by the built-in functions `input()` and `raw_input()`. It should be noted that most other I/O operations such as the `read()` and `readline()` methods of files return an empty string to signal EOF instead of raising an exception.

`FloatingPointError`
Failed floating-point operation. 

`GeneratorExit`
Raised inside a generator function to signal termination.This happens when a generator is destroyed prematurely (before all generator values are consumed) or the `close()` method of a generator is called. 

`IOError`
Failed I/O operation.

`ImportError`
Raised when an import statement can’t find a module or when from can’t find a name in a module.

`IndentationError`
Indentation error. A subclass of SyntaxError.

`IndexError`
Sequence subscript out of range. A subclass of LookupError.

`KeyError`
Key not found in a mapping. A subclass of LookupError.

`KeyboardInterrupt`
Raised when the user hits the interrupt key (usually Ctrl+C).

`MemoryError`
Recoverable out-of-memory error.

`NameError`
Name not found in local or global namespaces.

`NotImplementedError`
Unimplemented feature. Can be raised by base classes that require derived classes to implement certain methods. A subclass of `RuntimeError`.

`OSError`
Operating system error. Primarily raised by functions in the os module.The value is the
same as for `IOError`. A subclass of `EnvironmentError`.

`OverflowError`
Result of an integer value being too large to be represented.This exception usually only
arises if large integer values are passed to objects that internally rely upon fixedprecision
machine integers in their implementation. 

`ReferenceError`
Result of accessing a weak reference after the underlying object has been destroyed. 

`RuntimeError`
A generic error not covered by any of the other categories.

`StopIteration`
Raised to signal the end of iteration.This normally happens in the `next()` method of an object or in a generator function.

`SyntaxError`
Parser syntax error. Instances have the attributes filename, lineno, offset, and text, which can be used to gather more information.

`SystemError`
Internal error in the interpreter.The value is a string indicating the problem.

`SystemExit`
Raised by the `sys.exit()` function.The value is an integer indicating the return code. If it’s necessary to exit immediately, `os._exit()` can be used.

`TabError`
Inconsistent tab usage. Generated when Python is run with the `-tt` option. A subclass of SyntaxError.

`TypeError`
Occurs when an operation or a function is applied to an object of an inappropriate type.

`UnboundLocalError`
Unbound local variable referenced.This error occurs if a variable is referenced before it’s defined in a function. A subclass of `NameError`.

`UnicodeError`
Unicode encoding or decoding error. A subclass of `ValueError`.

`UnicodeEncodeError`
Unicode encoding error. A subclass of `UnicodeError`.

`UnicodeDecodeError`
Unicode decoding error. A subclass of `UnicodeError`.

`UnicodeTranslateError`
Unicode error occurred during translation. A subclass of UnicodeError.

`ValueError`
Generated when the argument to a function or an operation is the right type but an inappropriate value.

`WindowsError`
Generated by failed system calls on Windows. A subclass of `OSError`.

`ZeroDivisionError`
Dividing by zero. A subclass of `ArithmeticError`.


# 12.3 Built-In Warnings

Python has a warnings module that is typically used to notify programmers about deprecated features.

```python
port warnings
warnings.warn("The MONDO flag is no longer supported", DeprecationWarning)
```

`Warning`
The base class of all warnings. A subclass of `Exception`.

`UserWarning`
A generic user-defined warning. A subclass of `Warning`.

`DeprecationWarning`
A warning for deprecated features. A subclass of `Warning`.

`SyntaxWarning`
A warning for deprecated Python syntax. A subclass of `Warning`.

`RuntimeWarning`
A warning for potential runtime problems. A subclass of `Warning`.

`FutureWarning`
A warning that the behavior of a feature will change in the future. A subclass of `Warning`.

Warnings are different than exceptions in that the issuing of a warning with the `warn()` function may or may not cause a program to stop.


# 12.4 future_builtins

The  `future_builtins` module, only available in Python 2, provides implementations of the built-in functions whose behavior is changed in Python 3.

```python
# Produces the same output as repr()
ascii(object)

# Creates an iterator instead of a list.The same as itertools.ifilter()
filter(function, iterable)

'''
Creates a hexadecimal string, but uses the _ _index_ _() special method to get an integer
value instead of calling _ _hex_ _().
'''
hex(object)

# Creates an iterator instead of a list.The same as itertools.imap().
map(function, iterable, ...)

'''
Creates an octal string, but uses the _ _index_ _() special method to get an integer
value instead of calling _ _oct_ _().
'''
oct(object)

'''
Creates an iterator instead of a list.The same as itertools.izip().
Be aware that the functions listed in this module are not a complete
'''
zip(iterable, iterable, ... )
```




# Navigation

[Table of Contents](README.md)

Prev: [11、测试、调试、探查与调优](11、测试、调试、探查与调优.md)

Next: [13. Python Runtime Services](13-python-runtime-services.md)
