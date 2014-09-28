# lric

<img src="resources/images/elric-small.jpg" />

*An LFE riak & riak cs client wrapper*


## Introduction

Mostly because the modules in the Erlang client for riak are too cumbersome.


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

And then do the usual:

```bash
    $ rebar get-deps
    $ rebar compile
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

Let's start up a link to the Riak server and define some variables:

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

That's the complete Riak object; how do we get the value? Simple call
the appropriate object function:

```cl
> (binary_to_list (lrico:get-value result))
"a value"
```

For more usage examples, see the docs (all of which were converted from
Basho's Riak guide):

 * <a href="doc/crud-ops.md">CRUD Operations</a>
 * <a href="doc/querying.md">A Taste of Querying</a>
 * <a href="doc/obj-model.md">Object Modeling</a>
