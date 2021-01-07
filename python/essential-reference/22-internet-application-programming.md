<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [22.1 `ftplib`](#221-ftplib)
- [22.2 `http`](#222-http)
  - [`http.client`](#httpclient)
  - [`http.server`](#httpserver)
  - [`http.cookies`](#httpcookies)
  - [`http.cookiejar`](#httpcookiejar)
- [22.3 `smtplib`](#223-smtplib)
- [22.4 `urllib`](#224-urllib)
  - [`urlib.request`](#urlibrequest)
  - [`urllib.parse`](#urllibparse)
  - [`urllib.error`](#urlliberror)
  - [`urllib.robotparser`](#urllibrobotparser)
- [22.5 `xmlrpc`](#225-xmlrpc)
  - [`xmlrpc.client`](#xmlrpcclient)
  - [`xmlrpc.server`](#xmlrpcserver)
- [Navigation](#navigation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 22.1 `ftplib`

The `ftplib` module implements the client side of the FTP protocol. It’s rarely necessary to use this module directly because the `urllib` package provides a higher-level interface. However, this module may still be useful if you want to have more control over the low-level details of an FTP connection.

`FTP([host [, user [, passwd [, acct [, timeout]]]]])` Creates an object representing an FTP connection.

An instance `f` of FTP has the following methods:   

- `f.abort()` Attempts to abort a file transfer that is in progress.
- `f.close()` Closes the FTP connection.
- `f.connect(host [, port [, timeout]])` Opens an FTP connection to a given host and port.
- `f.cwd(pathname)` Changes the current working directory on the server to pathname.   
- `f.delete(filename)` Removes the file filename from the server.
- `f.dir([dirname [, ... [, callback]]])` Generates a directory listing as produced by the 'LIST' command.
- `f.login([user, [passwd [, acct]]])` Logs in to the server using the specified username, password, and account.
- `f.quit()` Closes the FTP connection by sending the 'QUIT' command to the server.
- `f.retrbinary(command, callback [, blocksize [, rest]])` Returns the results of executing a command on the server using binary transfer mode.
- `f.retrlines(command [, callback])` Returns the results of executing a command on the server using text transfer mode.
- `f.sendcmd(command)` Sends a simple command to the server and returns the server response.


# 22.2 `http`

The `http` package consists of modules for writing HTTP clients and servers as well as support for state management (cookies).

## `http.client`

The `http.client` module provides low-level support for the client side of HTTP. In Python 2, this module is called `httplib`.

`HTTPConnection(host [,port])`   Creates an HTTP connection.

`HTTPSConnection(host [, port [, key_file=kfile [, cert_file=cfile ]]])`   Creates an HTTP connection but uses a secure socket.

- `h.connect()`   Initializes the connection to the host and port given to `HTTPConnection()` or `HTTPSConnection()`.
- `h.close()`   Closes the connection.   
- `h.send(bytes)`   Sends a byte string, bytes, to the server.
- `h.putrequest(method, selector [, skip_host [, skip_accept_encoding]]`)   Sends a request to the server.
- `h.putheader(header, value, ...)`   Sends an RFC-822–style header to the server.
- `h.request(method, url [, body [, headers]])`   Sends a complete HTTP request to the server.
- `h.getresponse()`   Gets a response from the server and returns an HTTPResponse instance that can be used to read data.

An `HTTPResponse` instance, `r`, as returned by the `getresponse()` method, supports the following methods:   

- `r.read([size])`   Reads up to size bytes from the server.
- `r.getheaders()`   Returns a list of `(header, value)` tuples.
- `r.status`   HTTP status code returned by the server.

## `http.server`

The `http.server` module provides various classes for implementing HTTP servers. In Python 2, the contents of this module are split across three library modules: `BaseHTTPServer`, `CGIHTTPServer`, and `SimpleHTTPServer`.

The following class implements a basic HTTP server. In Python 2, it is located in the BaseHTTPServer module.   

`HTTPServer(server_address, request_handler)`   Creates a new HTTPServer object.

`HTTPServer` inherits directly from `TCPServer` defined in the `socketserver` module.

`SimpleHTTPRequestHandler` and `CGIHTTPRequestHandler` Two prebuilt web server handler classes can be used if you want to quickly set up a simple stand-alone web server.

The `BaseHTTPRequestHandler` class is a base class that’s used if you want to define your own custom HTTP server handling. The prebuilt handlers such as `SimpleHTTPRequestHandler` and `CGIHTTPRequestHandler` inherit from this. In Python 2, this class is defined in the `BaseHTTPServer` module.

`BaseHTTPRequestHandler.error_message_format` Format string used to build error messages sent to the client.

`BaseHTTPRequestHandler.responses`   Mapping of integer HTTP error codes to two-element tuples (message, explain) that describe the problem.

When created to handle a connection, an instance, `b`, of `BaseHTTPRequestHandler` has the following attributes:

- `b.send_error(code [, message])` Sends a response for an unsuccessful request.
- `b.send_response(code [, message])` Sends a response for a successful request.
- `b.send_header(keyword, value)` Writes a MIME header entry to the output stream.
- `b.log_error(format, ...)` Logs an error message.

## `http.cookies`

The `http.cookies` module provides server-side support for working with HTTP cookies. In Python 2, the module is called Cookie.

The` http.cookies` module simplifies the task of generating cookie values by providing a special dictionary-like object which stores and manages collections of cookie values known as **morsels**. Each morsel has a name, a value, and a set of optional attributes containing metadata to be supplied to the browser `{expires, path, comment, domain, max-age, secure, version, httponly}`.

`SimpleCookie([input])`   Defines a cookie object in which cookie values are stored as simple strings.

- `c.output([attrs [,header [,sep]]])`   Generates a string suitable for use in setting cookie values in HTTP headers.
- `c.load(rawdata)`   Loads the cookie c with data found in rawdata.

In addition, the morsel m has the following methods and attributes:   

- `m.value`   A string containing the raw value of the cookie
- `m.set(key,value,coded_value)`   Sets the values of m.key, m.value, and m.
- `m.output([attrs [,header]])`   Produces the HTTP header string for this morsel.

## `http.cookiejar`

The `http.cookiejar` module provides client-side support for storing and managing HTTP cookies. In Python 2, the module is called `cookielib`.

`CookieJar()` An object that manages HTTP cookie values, storing cookies received as a result of HTTP requests, and adding cookies to outgoing HTTP requests.

# 22.3 `smtplib`

The `smtplib` module provides a low-level SMTP client interface that can be used to send mail using the SMTP protocol described in RFC 821 and RFC 1869.

`SMTP([host [, port]])` Creates an object representing a connection to an SMTP server.

An instance s of SMTP has the following methods:   

- `s.connect([host [, port]])` Connects to the SMTP server on `host`.
- `s.login(user, password)` Logs into the server if authentication is required.
- `s.sendmail(fromaddr, toaddrs, message)`   Sends a mail message to the server.


# 22.4 `urllib`

The `urllib` package provides a high-level interface for writing clients that need to interact with HTTP servers, FTP servers, and local files.

In Python 2, the `urllib` functionality is spread across several different library modules including `urllib`, `urllib2`, `urlparse`, and `robotparser`. In Python 3, all of this functionality has been consolidated and reorganized under the `urllib` package.

## `urlib.request`

The `urllib.request` module provides functions and classes to open and fetch data from URLs. In Python 2, this functionality is found in a module `urllib2`.

`urlopen(url [, data [, timeout]])`   Opens the URL url and returns a file-like object that can be used to read the returned data.

`Request(url [, data [, headers [, origin_req_host [, unverifiable]]]])` Creates a new Request instance.

An instance `r` of Request has the following methods:   

- `r.add_data(data)`Adds data to a request.
- `r.add_header(key, val)` Adds header information to the request.
- `r.get_host()` Returns the host to which the request will be sent.

## `urllib.parse`

The `urllib.parse` module is used to manipulate URL strings such as "http://www.python.org".

`urlparse(urlstring [, default_scheme [, allow_fragments]])` Parses the URL in urlstring and returns a `ParseResult` instance.

A `ParseResult` instance can be turned back into a URL string using `r.geturl()`.   

`urlunparse(parts)` Constructs a URL string from a tuple-representation of a URL as returned by `urlparse()`.

`urlsplit(url [, default_scheme [, allow_fragments]])` The same as `urlparse()` except that the parameters portion of a URL is left unmodified in the path

The following functions are used to encode and decode data that make up URLs.   
- `quote(string [, safe [, encoding [, errors]]])`   Replaces special characters in string with escape sequences suitable for including in a URL.
- `unquote(string [, encoding [, errors]])`   Replaces escape sequences of the form '%xx' with their single-character equivalent.

## `urllib.error`

The `urllib.error` module defines exceptions used by the `urllib` package.

`HTTPError`   Raised to indicate problems with the HTTP protocol.

`URLError`   Error raised by handlers when a problem is detected.

## `urllib.robotparser`

The `urllib.robotparser` module (`robotparser` in Python 2) is used to fetch and parse the contents of 'robots.txt' files used to instruct web crawlers.


# 22.5 `xmlrpc`

The `xmlrpc` package contains modules for implement XML-RPC servers and clients. XML-RPC is a remote procedure call mechanism that uses XML for data encoding and HTTP as a transport mechanism.

## `xmlrpc.client`

The `xmlrpc.client` module is used to write XML-RPC clients. In Python 2, this module is called `xmlrpclib`. To operate as a client, you create an instance of ServerProxy:

`ServerProxy(uri, [, transport [, encoding [, verbose [, allow_once [, use_datetime]]]])`

If the remote XML-RPC server supports introspection, the following methods may be available:   

`s.system.listMethods()`   Returns a list of strings listing all the methods provided by the XML-RPC server.


The following utility functions are available in the `xmlrpclib` module:

- `dumps(params [, methodname [, methodresponse [, encoding [, allow_none]]]])` Converts `params` into an XML-RPC request or response, where params is either a tuple of arguments or an instance of the `Fault` exception. `methodname` is the name of the method as a string.
- `loads(data) `  Converts `data` containing an XML-RPC request or response into a tuple `(params, methodname)` where params is a tuple of parameters and `methodname` is a string containing the method name.

## `xmlrpc.server`

The `xmlrpc.server` module contains classes for implementing different variants of XML-RPC servers. In Python 2, this functionality is found in two separate modules: `SimpleXMLRPCServer` and `DocXMLRPCServer`.

`SimpleXMLRPCServer(addr [, requestHandler [, logRequests]])`   Creates an XML-RPC server listening on the socket address addr (for example, ('localhost',8080)).

An instance, `s`, of `SimpleXMLRPCServer` or `DocXMLRPCServer` has the following methods:   

- `s.register_function(func [, name])`   Registers a new function, `func`, with the XML-RPC server.

An instance of `DocXMLRPCServer` additionally provides these methods:   

- `s.set_server_title(server_title)`   Sets the title of the server in HTML documentation. The string is placed in the HTML `<title>` tag.   
- `s.set_server_name(server_name)`   Sets the name of the server in HTML documentation. The string appears at the top of the page in an `<h1>` tag.   
- `s.set_server_documentation(server_documentation)`   Adds a descriptive paragraph to the generated HTML output. This string is added right after the server name, but before a description of the XML-RPC functions.


# Navigation

[Table of Contents](README.md)

Prev: [21. Network Programming and Sockets](21-network-programming-sockets.md)

Next: [23. Web Programming](23-web-programming.md)
