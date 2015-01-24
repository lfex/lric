# lric

*An LFE riak & riak cs client wrapper*

<img src="resources/images/elric-small.jpg" />


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
by Billo from the [Basho originals]()):

 * [Taste of Riak](http://billo.gitbooks.io/lfe-taste-of-riak/content/index.html)
 * The Little Riak Book (TBD)
 * Basic Usage (TBD)
 * Riak Search (TBD)
 * Riak Data Types (TBD)
