<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [18.1 `bz2`](#181-bz2)
- [18.2 `filecmp`](#182-filecmp)
- [18.3 `fnmatch`](#183-fnmatch)
- [18.4 `glob`](#184-glob)
- [18.5 `gzip`](#185-gzip)
- [18.6 `shutil`](#186-shutil)
- [18.7 `tarfile`](#187-tarfile)
- [18.8 `tempfile`](#188-tempfile)
- [18.9 `zipfile`](#189-zipfile)
- [18.10 `zlib`](#1810-zlib)
- [Navigation](#navigation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 18.1 `bz2`

The `bz2` module is used to read and write data compressed according to the bzip2 compression algorithm.

- `BZ2File(filename [, mode [, buffering [, compresslevel]]])` Opens a `.bz2` file, `filename`, and returns a file-like object.
- `BZ2Compressor([compresslevel])` Creates a compressor object that can be used to sequentially compress a sequence of data blocks. An instance, c, of BZ2Compressor has the following methods:
    * `c.compress(data)` Feeds new string data to the compressor object, `c`. Returns a string of compressed data if possible.
- `BZ2Decompressor()` Creates a decompressor object. An instance, `d`, of `BZ2Decompressor` supports just one method:
    * `d.decompress(data)` Given a chunk of compressed data in the string `data`, this method returns uncompressed data.
- `compress(data [, compresslevel])` Returns a compressed version of the data supplied in the string `data`.
- `decompress(data)` Returns a string containing the decompressed data in the string `data`.


# 18.2 `filecmp`

The `filecmp` module provides the following functions, which can be used to compare files and directories:

- `cmp(file1, file2 [, shallow])` Compares the files `file1` and `file2` and returns `True` if they’re equal, `False` if not.
- `dircmp(dir1, dir2 [, ignore[, hide]])` Creates a directory comparison object that can be used to perform various comparison operations on the directories `dir1` and `dir2`. A directory object, `d` has following methods and attribues:
    + `d.report()` Compares directories `dir1` and `dir2` and prints a report to `sys.stdout`.
    + `d.left_list` Lists the files and subdirectories in `dir1`.
    + `d.common_files`   Lists the files that are common to `dir1` and `dir2`.
    + `d.diff_files`   Lists the files with different contents in `dir1` and `dir2`.


# 18.3 `fnmatch`

The `fnmatch` module provides support for matching filenames using UNIX shell-style wildcard characters. This module only performs filename matching, whereas the `glob` module can be used to actually obtain file listings.

`fnmatch(filename, pattern)` Returns `True` or `False` depending on whether `filename` matches `pattern`.

`filter(names, pattern)` Applies the `fnmatch()` function to all of the names in the sequence names and returns a list of all `names` that match `pattern`.



# 18.4 `glob`

The `glob` module returns all filenames in a directory that match a pattern specified using the rules of the UNIX shell (as described in the fnmatch module).   

`glob(pattern)` Returns a list of pathnames that match `pattern`.


# 18.5 `gzip`

The `gzip` module provides a class, `GzipFile`, that can be used to read and write files compatible with the GNU gzip program. `GzipFile` objects work like ordinary files except that data is automatically compressed or decompressed.   

`GzipFile([filename [, mode [, compresslevel [, fileobj]]]])` Opens a `GzipFile`.


# 18.6 `shutil`

The `shutil` module is used to perform high-level file operations such as copying, removing, and renaming. The functions in this module should only be used for proper files and directories. In particular, they do not work for special kinds of files on the file system such as named pipes, block devices, etc.

- `copy(src,dst)` Copies the file `src` to the file or directory `dst`, retaining file permissions. src and dst are strings.
- `move(src, dst)` Moves a file or directory `src` to `dst`.
- `rmtree(path [, ignore_errors [, onerror]])` Deletes an entire directory tree.


# 18.7 `tarfile`

The `tarfile` module is used to manipulate tar archive files. Using this module, it is possible to read and write tar files, with or without compression.

o`pen([name [, mode [, fileobj [, bufsize]]]])` Creates a new `TarFile` object with the pathname `name`.

A `TarFile` instance, `t`, returned by open() supports the following methods and attributes:   
- `t.add(name [, arcname [, recursive]])` Adds a new file to the tar archive.
- `t.extract(member [, path])` Extracts a member from the archive, saving it to the current directory.
- `t.getmember(name)` Looks up archive member `name` and returns a `TarInfo` object containing information about it.
- `t.gettarinfo([name [, arcname [, fileobj]]])` Returns a `TarInfo` object corresponding to a file, `name`, on the file system or an open file object, fi`leobj. arcname is an alternative name for the object in the archive.
- `t.list([verbose])` Lists the contents of the archive to `sys.stdout`.
- `t.next()` A method used for iterating over the members of an archive.


# 18.8 `tempfile`

The `tempfile` module is used to generate temporary filenames and files.  
- `mkdtemp([suffix [,prefix [, dir]]])`   Creates a temporary directory accessible only by the owner of the calling process and returns its absolute pathname.
-`TemporaryFile([mode [, bufsize [, suffix [,prefix [, dir]]]]])`   Creates a temporary file using `mkstemp()` and returns a file-like object that supports the same methods as an ordinary file object.
- `NamedTemporaryFile([mode [, bufsize [, suffix [,prefix [, dir [, delete ]]]]]])`  Creates a temporary file just like `TemporaryFile()` but makes sure the filename is visible on the file system.

# 18.9 `zipfile`

The `zipfile` module is used to manipulate files encoded in the popular zip format (originally known as PKZIP, although now supported by a wide variety of programs).

- `ZipFile(filename [, mode [, compression [,allowZip64]]])`   Opens a zip file, filename, and returns a ZipFile instance.
- `ZipInfo([filename [, date_time]])`   Manually creates a new ZipInfo instance, used to contain information about an archive member.

An instance, `z`, of `ZipFile` or `PyZipFile` supports the following methods and attributes:

- `z.extract(name [, path [, pwd ]])`   Extracts a file from the archive and places it in the current working directory.
- `z.open(name [, mode [, pwd]])`   Opens an archive member named name and returns a file-like object for reading the contents.
- `z.read(name [,pwd])`   Reads archive contents for member name and returns the data as a string.
- `z.write(filename[, arcname[, compress_type]])`   Writes filename to the archive with the archive name arcname.


# 18.10 `zlib`

The `zlib` module supports data compression by providing access to the zlib library.

- `compress(string [, level])`   Compresses the data in string, where level is an integer from 1 to 9 controlling the level of compression.
- `decompress(string [, wbits [, buffsize]])`   Decompresses the data in string. wbits controls the size of the window buffer, and buffsize is the initial size of the output buffer. Raises error if an error occurs.


# Navigation

[Table of Contents](README.md)

Prev: [17. Python Database Access](17-python-database-access.md)

Next: [19. Operating System Services](19-operating-system-services.md)
