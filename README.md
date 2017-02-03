# lric

[![Build Status][travis badge]][travis]
[![LFE Versions][lfe badge]][lfe]
[![Erlang Versions][erlang badge]][versions]
[![Tags][github tags badge]][github tags]
[![Downloads][hex downloads]][hex package]

[![][project-logo]][project-logo-large]

*An LFE riak & riak cs client wrapper*


## Introduction

Mostly because the module names of the Erlang Riak client are a bit cumbersome.
And not Lispy.


## Prerequisites

You will need ``protoc`` in your ``$PATH``. Installing Protocol Buffers will
do the trick.


## Installation

Just add it to your ``rebar.config`` deps:

```erlang
  {deps, [
    ...
    {lric, ".*",
      {git, "git@github.com:billosys/lric.git", "master"}}
      ]}.
```

And then do:

```bash
    $ make compile
```


## Usage

Below is a quick sample from the Riak docs converted to LFE and lric. First,
let's start up the LFE REPL:

```bash
$ make repl-no-deps
...
LFE Shell V6.2 (abort with ^G)
>
```

Then let's connect to the Riak server and define some variables:

```cl
> (set `#(ok ,pid) (lric:start-link "127.0.0.1" 8087))
#(ok <0.32.0>)
> (set my-bucket (binary "test"))
#B(116 101 115 116)
> (set key (binary "key"))
#B(107 101 121)
> (set value (binary "a value"))
#B(97 32 118 97 108 117 101)
```

With these in place, we can create an object:

```cl
> (set obj (lrico:new my-bucket key value))
#(riakc_obj
  #B(116 101 115 116)
  #B(107 101 121)
  undefined
  ()
  undefined
  #B(97 32 118 97 108 117 101))
>
```

and then store it in Riak:

```cl
> (lric:put pid obj)
ok
```

Now let's get it back out of Riak:

```cl
> (set `#(ok ,result) (lric:get pid my-bucket key))
#(ok
  #(riakc_obj
    #B(116 101 115 116)
    #B(107 101 121)
    #B(107 206 97 96 96 96 204 96 ...)
    (#(#(dict
         2
         16
         16
         8
         80
         48
         #(() () () () () () () () () () () () ...)
         #(#(() () () () () () () () () () ...)))
       #B(97 32 118 97 108 117 101)))
    undefined
    undefined))
```

That's the complete Riak object; how do we get just the value? Simply call
the appropriate object function:

```cl
> (lrico:get-value result)
#B(97 32 118 97 108 117 101)
```

Or the more readable:

```cl
> (binary_to_list (lrico:get-value result))
"a value"
```


## Documentation

For more usage examples, see the following docs (all of which are being ported
by Billo from the [Basho originals](http://docs.basho.com/riak/latest/)):

 * [Taste of Riak](http://billo.gitbooks.io/lfe-taste-of-riak/content/index.html)
 * The Little Riak Book (TBD)
 * Basic Usage (TBD)
 * Riak Search (TBD)
 * Riak Data Types (TBD)


<!-- Named page links below: /-->

[project-logo]: resources/images/elric-small.png
[project-logo-large]: resources/images/elric-large.png
[org]: https://github.com/lfex
[github]: https://github.com/lfex/lric
[gitlab]: https://gitlab.com/lfex/lric
[travis]: https://travis-ci.org/lfex/lric
[travis badge]: https://img.shields.io/travis/lfex/lric.svg
[lfe]: https://github.com/rvirding/lfe
[lfe badge]: https://img.shields.io/badge/lfe-1.2.0-blue.svg
[erlang badge]: https://img.shields.io/badge/erlang-17%20to%2019-blue.svg
[versions]: https://github.com/lfex/lric/blob/master/.travis.yml
[github tags]: https://github.com/lfex/lric/tags
[github tags badge]: https://img.shields.io/github/tag/lfex/lric.svg
[github downloads]: https://img.shields.io/github/downloads/atom/atom/total.svg
[hex badge]: https://img.shields.io/hexpm/v/lric.svg?maxAge=2592000
[hex package]: https://hex.pm/packages/lric
[hex downloads]: https://img.shields.io/hexpm/dt/lric.svg
