<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [23.1 `cgi`](#231-cgi)
  - [CGI Programming Advice](#cgi-programming-advice)
- [23.2 `cgitb`](#232-cgitb)
- [23.3 `wsgiref`](#233-wsgiref)
  - [`wsgiref.simple_server`](#wsgirefsimple_server)
  - [`wsgiref.handlers`](#wsgirefhandlers)
  - [`wsgiref.validate`](#wsgirefvalidate)
- [23.4 `webbrowser`](#234-webbrowser)
- [Navigation](#navigation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 23.1 `cgi`

The `cgi` module is used to implement CGI scripts, which are programs typically executed by a webserver when it wants to process user input from a form or generate dynamic content of some kind.

When a request corresponding to a CGI script is submitted, the webserver executes the CGI program as a subprocess.

Most of the work in the cgi module is performed by creating an instance of the `FieldStorage` class.   

`FieldStorage([input [, headers [, outerboundary [, environ [, keep_blank_values [, strict_parsing]]]]]])`

A `FieldStorage` instance form works similarly to a dictionary. For example, `f = form [key]` will extract an entry for a given parameter key.

- `form.getvalue(fieldname [, default])`   Returns the value of a given field with the name fieldname.
- `form.getlist(fieldname)`   Returns a list of all values defined for fieldname.

The following utility functions are often used in CGI scripts:

- `parse_header(string)`   Parses the data supplied after an HTTP header field such as 'content-type'.
- `print_form(form)`   Formats the data supplied on a form in HTML.

## CGI Programming Advice

First, don’t write CGI scripts where you are using a huge number of `print` statements to produce hard-coded HTML output. The resulting program will be a horrible tangled mess of Python and HTML that is not only impossible to read, but also impossible to maintain

Second, if you need to save data from a CGI script, try to use a database.

Finally, if you find yourself writing dozens of CGI scripts and code that has to deal with low-level details of HTTP such as cookies, authentication, encoding, and so forth, you may want to consider a web framework instead.


# 23.2 `cgitb`

This module provides an alternative exception handler that displays a detailed report whenever an uncaught exception occurs.

`enable([display [, logdir [, context [, format]]]])`   Enables special exception handling.

`handle([info])`   Handles an exception using the default settings of the `enable()` function.


# 23.3 `wsgiref`

WSGI (Python Web Server Gateway Interface) is a standardized interface between webservers and web applications that is designed to promote portability of applications across different webservers and frameworks.

The `wsgiref` package is a reference implementation that can be used for testing, validation, and simple deployments.

With WSGI, a web application is implemented as a function or callable object `webapp(environ, start_response)` that accepts two arguments.

## `wsgiref.simple_server`

The `wsgiref.simple_server` module implements a simple stand-alone HTTP server that runs a single WSGI application. There are just two functions of interest:  
- `make_server(host, port, app)`   Creates an HTTP server that accepts connections on the given host name `host` and port number `port`.
- `demo_app(environ, start_response)`   A complete WSGI application.

## `wsgiref.handlers`

The `wsgiref.handlers` module contains handler objects for setting up a WSGI execution environment so that applications can run within another webserver

`CGIHandler()`   Creates a WSGI handler object that runs inside a standard CGI environment.

`BaseCGIHandler(stdin, stdout, stderr, environ [, multithread [, multiprocess]])`   Creates a WSGI handler that operates within a CGI environment, but where the standard I/O streams and environment variables might be set up in a different way.

`SimpleHandler(stdin, stdout, stderr, environ [, multithread [, multiprocess]]) `  Creates a WSGI handler that is similar to BaseCGIHandler, but which gives the underlying application direct access to stdin, stdout, stderr, and environ.

## `wsgiref.validate`

The `wsgiref.validate` module has a function that wraps a WSGI application with a validation wrapper to ensure that both it and the server are operating according to the standard.

`validator(app)` Creates a new WSGI application that wraps the WSGI application app.


# 23.4 `webbrowser`

The `webbrowser` module provides utility functions for opening documents in a web browser in a platform-independent manner. The main use of this module is in development and testing situations.

`open(url [, new [, autoraise]])`   Displays url with the default browser on the system.

`get([name])`   Returns a controller object for manipulating a browser.

`register(name, constructor[, controller])`   Registers a new browser type for use with the get() function.


# Navigation

[Table of Contents](README.md)

Prev: [22. Internet Application Programming](22-internet-application-programming.md)

Next: 
