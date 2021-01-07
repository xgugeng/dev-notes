<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [15.1 `abc`](#151-abc)
- [15.2 `array`](#152-array)
- [15.3 `bisect`](#153-bisect)
- [15.4 `collections`](#154-collections)
  - [`deque`](#deque)
  - [`defaultdict`](#defaultdict)
  - [`namedtuple`](#namedtuple)
- [15.5 `contextlib`](#155-contextlib)
- [15.6 `functools`](#156-functools)
- [15.7 `heapq`](#157-heapq)
- [15.8 `itertools`](#158-itertools)
- [15.9 `operator`](#159-operator)
- [Navigation](#navigation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 15.1 `abc`

The `abc` module defines a metaclass and a pair of decorators for defining new abstract base classes.

```python
from abc import ABCMeta

class MyABC:
    __metaclass__ = ABCMeta

MyABC.register(tuple)

assert issubclass(tuple, MyABC)
assert isinstance((), MyABC)
```


# 15.2 `array`

The `array` module defines a new object type, array, that works almost exactly like a list, except that its contents are constrained to a single type. When items are inserted into an array, a `TypeError` exception is generated if the type of the item doesn’t match the type used to create the array.

```python
array('l')
array('c', 'hello world')
array('u', u'hello \u2641')
array('l', [1, 2, 3, 4, 5])
array('d', [1.0, 2.0, 3.14])
```


# 15.3 `bisect`

The `bisect` module provides support for keeping lists in sorted order. It uses a bisection algorithm to do most of its work.

```python
>>> data = [('red', 5), ('blue', 1), ('yellow', 8), ('black', 0)]
>>> data.sort(key=lambda r: r[1])
>>> keys = [r[1] for r in data]         # precomputed list of keys
>>> data[bisect_left(keys, 0)]
('black', 0)
>>> data[bisect_left(keys, 1)]
('blue', 1)
>>> data[bisect_left(keys, 5)]
('red', 5)
>>> data[bisect_left(keys, 8)]
('yellow', 8)
```

# 15.4 `collections`

The `collections` module contains high-performance implementations of a few useful container types, abstract base classes for various kinds of containers, and a utility function for creating name-tuple objects.

## `deque`

A `deque` allows items to be inserted or removed from either end of the queue. Operations that add new items to a deque are also thread-safe.

```
>>> from collections import deque
>>> d = deque('ghi')                 # make a new deque with three items
>>> for elem in d:                   # iterate over the deque's elements
...     print elem.upper()
G
H
I

>>> d.append('j')                    # add a new entry to the right side
>>> d.appendleft('f')                # add a new entry to the left side
>>> d                                # show the representation of the deque
deque(['f', 'g', 'h', 'i', 'j'])

>>> d.pop()                          # return and remove the rightmost item
'j'
>>> d.popleft()                      # return and remove the leftmost item
'f'
>>> list(d)                          # list the contents of the deque
['g', 'h', 'i']
>>> d[0]                             # peek at leftmost item
'g'
>>> d[-1]                            # peek at rightmost item
```

## `defaultdict`

dict subclass that calls a factory function to supply missing values.

```
>>> s = [('yellow', 1), ('blue', 2), ('yellow', 3), ('blue', 4), ('red', 1)]
>>> d = defaultdict(list)
>>> for k, v in s:
...     d[k].append(v)
...
>>> d.items()
[('blue', [2, 4]), ('red', [1]), ('yellow', [1, 3])]
```

## `namedtuple`

The `collections` module contains a function `namedtuple()` that is used to create subclasses of tuple in which attribute names can be used to access tuple elements.

A named tuple can be useful if defining objects that really only serve as a data structures. The benefit of the named tuple is that it is more memory-efficient and supports various tuple operations such as unpacking. The downside to a named tuple is that attribute access is not as efficient as with a class.

```python
EmployeeRecord = namedtuple('EmployeeRecord', 'name, age, title, department, paygrade')

import csv
for emp in map(EmployeeRecord._make, csv.reader(open("employees.csv", "rb"))):
    print emp.name, emp.title

import sqlite3
conn = sqlite3.connect('/companydata')
cursor = conn.cursor()
cursor.execute('SELECT name, age, title, department, paygrade FROM employees')
for emp in map(EmployeeRecord._make, cursor.fetchall()):
    print emp.name, emp.title
```

The `collections` module defines a series of abstract base classes. The purpose of these classes is to describe programming interfaces on various kinds of containers such as lists, sets, and dictionaries. There are two primary uses of these classes. First, they can be used as a base class for user-defined objects that want to emulate the functionality of built-in container types. Second, they can be used for type checking.

- `Container`
- `Hashable`
- `Iterable`
- `Iterator`
- `Callable`
- `Sequence`
- `Set`
- `Mapping`


# 15.5 `contextlib`

The `contextlib` module provides a decorator and utility functions for creating context managers used in conjunction with the with statement.

When the statement with `foo(args)` as value appears, the generator function is executed with the supplied arguments until the first yield statement is reached.

```
from contextlib import contextmanager

@contextmanager
def tag(name):
    print "<%s>" % name
    yield
    print "</%s>" % name

>>> with tag("h1"):
...    print "foo"
...
<h1>
foo
</h1>
```


# 15.6 `functools`

The `functools` module contains functions and decorators that are useful for creating higher-order functions, functional programming, and decorators.

`functools.partial(func[,*args][, **keywords])` return a new partial object which when called will behave like `func` called with the positional arguments `args` and keyword arguments keywords. If more arguments are supplied to the call, they are appended to `args`. If additional keyword arguments are supplied, they extend and override keywords. Roughly equivalent to:

```python
def partial(func, *args, **keywords):
    def newfunc(*fargs, **fkeywords):
        newkeywords = keywords.copy()
        newkeywords.update(fkeywords)
        return func(*(args + fargs), **newkeywords)
    newfunc.func = func
    newfunc.args = args
    newfunc.keywords = keywords
    return newfunc
```


# 15.7 `heapq`

The `heapq` module implements a priority queue using a heap.


```
>>> def heapsort(iterable):
...     h = []
...     for value in iterable:
...         heappush(h, value)
...     return [heappop(h) for i in range(len(h))]
...
>>> heapsort([1, 3, 5, 7, 9, 2, 4, 6, 8, 0])
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```


# 15.8 `itertools`

The `itertools` module contains functions for creating efficient iterators, useful for looping over data in various ways.

**Infinite Iterators:**

| Iterator                                 | Arguments     | Results                                  | Example                                 |
| ---------------------------------------- | ------------- | ---------------------------------------- | --------------------------------------- |
| [`count()`](https://docs.python.org/2/library/itertools.html#itertools.count) | start, [step] | start, start+step, start+2*step, …       | `count(10) --> 10 11 12 13 14 ...`      |
| [`cycle()`](https://docs.python.org/2/library/itertools.html#itertools.cycle) | p             | p0, p1, … plast, p0, p1, …               | `cycle('ABCD') --> A B C D A B C D ...` |
| [`repeat()`](https://docs.python.org/2/library/itertools.html#itertools.repeat) | elem [,n]     | elem, elem, elem, … endlessly or up to n times | `repeat(10, 3) --> 10 10 10`            |

**Iterators terminating on the shortest input sequence:**

| Iterator                                 | Arguments                   | Results                                  | Example                                  |
| ---------------------------------------- | --------------------------- | ---------------------------------------- | ---------------------------------------- |
| [`chain()`](https://docs.python.org/2/library/itertools.html#itertools.chain) | p, q, …                     | p0, p1, … plast, q0, q1, …               | `chain('ABC', 'DEF') --> A B C D E F`    |
| [`compress()`](https://docs.python.org/2/library/itertools.html#itertools.compress) | data, selectors             | (d[0] if s[0]), (d[1] if s[1]), …        | `compress('ABCDEF', [1,0,1,0,1,1]) --> A C E F` |
| [`dropwhile()`](https://docs.python.org/2/library/itertools.html#itertools.dropwhile) | pred, seq                   | seq[n], seq[n+1], starting when pred fails | `dropwhile(lambda x: x<5, [1,4,6,4,1]) --> 6 4 1` |
| [`groupby()`](https://docs.python.org/2/library/itertools.html#itertools.groupby) | iterable[, keyfunc]         | sub-iterators grouped by value of keyfunc(v) |                                          |
| [`ifilter()`](https://docs.python.org/2/library/itertools.html#itertools.ifilter) | pred, seq                   | elements of seq where pred(elem) is true | `ifilter(lambda x: x%2, range(10)) --> 1 3 5 7 9` |
| [`ifilterfalse()`](https://docs.python.org/2/library/itertools.html#itertools.ifilterfalse) | pred, seq                   | elements of seq where pred(elem) is false | `ifilterfalse(lambda x: x%2, range(10)) --> 0 2 4 68` |
| [`islice()`](https://docs.python.org/2/library/itertools.html#itertools.islice) | seq, [start,] stop [, step] | elements from seq[start:stop:step]       | `islice('ABCDEFG', 2, None) --> C D E F G` |
| [`imap()`](https://docs.python.org/2/library/itertools.html#itertools.imap) | func, p, q, …               | func(p0, q0), func(p1, q1), …            | `imap(pow, (2,3,10), (5,2,3)) --> 32 9 1000` |
| [`starmap()`](https://docs.python.org/2/library/itertools.html#itertools.starmap) | func, seq                   | func(*seq[0]), func(*seq[1]), …          | `starmap(pow, [(2,5), (3,2), (10,3)]) --> 32 9 1000` |
| [`tee()`](https://docs.python.org/2/library/itertools.html#itertools.tee) | it, n                       | it1, it2, … itn splits one iterator into n |                                          |
| [`takewhile()`](https://docs.python.org/2/library/itertools.html#itertools.takewhile) | pred, seq                   | seq[0], seq[1], until pred fails         | `takewhile(lambda x: x<5, [1,4,6,4,1]) --> 1 4` |
| [`izip()`](https://docs.python.org/2/library/itertools.html#itertools.izip) | p, q, …                     | (p[0], q[0]), (p[1], q[1]), …            | `izip('ABCD', 'xy') --> Ax By`           |
| [`izip_longest()`](https://docs.python.org/2/library/itertools.html#itertools.izip_longest) | p, q, …                     | (p[0], q[0]), (p[1], q[1]), …            | `izip_longest('ABCD', 'xy', fillvalue='-') --> AxBy C- D-` |


# 15.9 `operator`

The `operator` module provides functions that access the built-in operators and special methods of the interpreter.

```
operator.lt(a, b)
operator.le(a, b)¶
operator.eq(a, b)
operator.ne(a, b)
operator.ge(a, b)
operator.gt(a, b)
operator.__lt__(a, b)
operator.__le__(a, b)
operator.__eq__(a, b)
operator.__ne__(a, b)
operator.__ge__(a, b)
operator.__gt__(a, b)
```


# Navigation

[Table of Contents](README.md)

Prev: [14. Mathematics](14-mathematics.md)

Next: [16. String and Text Handling](16-string-text-handling.md)
