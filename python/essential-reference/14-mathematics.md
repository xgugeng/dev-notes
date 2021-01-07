<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [14.1 `decimal`](#141-decimal)
- [14.2 `fractions`](#142-fractions)
- [14.3 `math`](#143-math)
- [14.4 `numbers`](#144-numbers)
- [14.5 `random`](#145-random)
- [Navigation](#navigation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 14.1 `decimal`

The Python `float` data type is represented using a double-precision binary floating-point encoding (usually as defined by the IEEE 754 standard). A subtle consequence of this encoding is that decimal values such as 0.1 can’t be represented exactly. Instead, the closest value is 0.10000000000000001.

The `decimal` module provides an implementation of the IBM General Decimal Arithmetic Standard, which allows for the exact representation of decimals. It also gives precise control over mathematical precision, significant digits, and rounding behavior.

The decimal module defines two basic data types: a `Decimal` type that represents a decimal number and a `Context` type that represents various parameters concerning computation such as precision and round-off error-handling.

```
>>> from decimal import *
>>> getcontext().prec = 6
>>> Decimal(1) / Decimal(7)
Decimal('0.142857')
>>> getcontext().prec = 28
>>> Decimal(1) / Decimal(7)
Decimal('0.1428571428571428571428571429')
```

Normally, new `Context` objects aren’t created directly. Instead, the function `getcontext()` or `localcontext()` is used to return the currently active `Context` object.

The decimal context is unique to each thread. Changes to the context only affect that thread and not others.


# 14.2 `fractions`

The `fractions` module defines a class `Fraction` that represents a rational number. An instance `f` of `Fraction` supports all of the usual mathematical operations.

```
>>> from fractions import Fraction
>>> Fraction(16, -10)
Fraction(-8, 5)
>>> Fraction(123)
Fraction(123, 1)
```


# 14.3 `math`

The `math` module defines the following standard mathematical functions. These functions operate on integers and floats but don't work with complex numbers (a seperate module `cmath` can).

- `acos(x)`
- `ceil(x)`
- `exp(x)`
- `isinf(x)`


# 14.4 `numbers`

The `numbers` module defines a series of abstract base classes that serve to organize various kinds of numbers.

- `Number`, A class that serves as the top of the numeric hierarchy.
- `Complex`, A class, inherits from `Number`, that represents the complex numbers, with `real` and `imag` attributes. 
- `Real`, Inherits from `Complex`.
- `Rational`, Inherits from `Real`.
- `Integral`, Inherits from `Rational`.
“The classes in this module are not meant to be instantiated. Instead, they can be used to perform various kinds of type checks on values”

The classes in this module are not meant to be instantiated. Instead, they can be used to perform various kinds of type checks on values.


# 14.5 `random`

The `random` module provides a variety of functions for generating pseudo-random numbers as well as functions for randomly generating values according to various distributions on the real numbers. 

Note, The functions in this module are not thread-safe.


# Navigation

[Table of Contents](README.md)

Prev: [13. Python Runtime Services](13-python-runtime-services.md)

Next: [15. Data Strutures, Algorithms, and Code Simplification](15-data-structure-algorithms.md)

