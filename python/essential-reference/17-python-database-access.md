<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [17.1 `Relational Database APO Specifications`](#171-relational-database-apo-specifications)
  - [Connections](#connections)
  - [Cursors](#cursors)
  - [Forming Queries](#forming-queries)
  - [Type Objects](#type-objects)
- [17.2 `sqlite3`](#172-sqlite3)
- [17.3 `DBM-Style Database Modules`](#173-dbm-style-database-modules)
- [17.4 `shelve`](#174-shelve)
- [Navigation](#navigation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 17.1 `Relational Database APO Specifications`

For accessing relational databases, the Python community has developed a standard known as the Python Database API Specification V2.0, or PEP 249 for short (the formal description can be found at [](http://www.python.org/dev/peps/pep-249/))

At a high level, the database API defines a set of functions and objects for connecting to a database server, executing SQL queries, and obtaining results. Two primary objects are used for this: 

1. a `Connection` object that manages the connection to the database and 
2. a `Cursor` object that is used to perform queries.

## Connections

To connect to a database, every database module provides a module-level function `connect(parameters)`. The exact parameters depend on the database but typically include information such as the 

- data source name, 
- user name, 
- password, 
- host name, and 
- database name.

## Cursors

In order to perform any operations on the database, you first create a connection `c` and then you call `c.cursor()` method to create a Cursor object.

- `cur.execute(query [, parameters])` Executes a query or command query on the database.
- `cur.fetchmany([size])` Returns a sequence of result rows (e.g., a list of tuples)

## Forming Queries

you should never manually form queries using Python string operations like `cur.execute("select * from table where name = "%s" % name")`. If you do, it opens up your code to a potential SQL injection attack.

All database modules provide their own mechanism for value substitution.

## Type Objects

When working with database data, built-in types such as integers and strings are usually mapped to an equivalent type in the database. However, for dates, binary data, and other special types, data management is more tricky.


# 17.2 `sqlite3`

The `sqlite3` module provides a Python interface to the SQLite database library.


# 17.3 `DBM-Style Database Modules`

- The `dbm` module is used to read standard UNIX-dbm database files. The gdbm module is used to read GNU dbm database files.
- The `dbhash` module is used to read database files created by the Berkeley DB library.
- The `dumbdbm` module is a pure-Python module that implements a simple DBM-style database on its own.

All of these modules provide an object that implements a persistent string-based dictionary. That is, it works like a Python dictionary except that all keys and values are restricted to strings. A database file is typically opened using a variation of the `open()` function.


# 17.4 `shelve`

The `shelve` module provides support for persistent objects using a special “shelf” object.

This object behaves like a dictionary except that all the objects it contains are stored on disk using a hash-table based database such as `dbhash`, `dbm` or `gdbm`. Unlike those modules, however, the values stored in a shelf are not restricted to strings. Instead, any object that is compatible with the pickle module may be stored. A shelf is created using the `shelve.open()` function.


# Navigation

[Table of Contents](README.md)

Prev: [16. String and Text Handling](16-string-text-handling.md)

Next: [18. File and Directory Handling](18-file-directory-handling.md)

