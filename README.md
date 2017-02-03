# lric

*Riak & Riak CS client wrappers for LFE*

<img src="resources/images/elric-small.jpg" />

## Introduction

Mostly because the module names of the Erlang Riak client are a bit
cumbersome. And not Lispy.

## Installation

You need to use rebar3. Just add it to your `rebar.config` deps:

```erlang
  {deps, [
    {lric, {git, "git@github.com:lfex/lric.git", {branch, "master"}}}
  ]}.
```

And then do:

```bash
$ rebar3 compile
```

## Usage

Below is a quick sample from the Riak docs converted to LFE and
lric. First, let's start up the LFE REPL:

```bash
$ lfe
Erlang/OTP 19 [erts-8.2.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false]

   ..-~.~_~---..
  (      \\     )    |   A Lisp-2+ on the Erlang VM
  |`-.._/_\\_.-':    |   Type (help) for usage info.
  |         g |_ \   |
  |        n    | |  |   Docs: http://docs.lfe.io/
  |       a    / /   |   Source: http://github.com/rvirding/lfe
   \     l    |_/    |
    \   r     /      |   LFE v1.3-dev (abort with ^G)
     `-E___.-'

lfe>
```

Then let's connect to the Riak server and define some variables:

```cl
lfe> (set `#(ok ,pid) (lric:start-link "127.0.0.1" 8087))
#(ok <0.32.0>)
lfe> (set my-bucket #"test")
#"test"
lfe> (set key #"key")
#"key"
lfe> (set value #"a value")
#"a value"
```

With these in place, we can create an object:

```cl
lfe> (set obj (lrico:new my-bucket key value))
#(riakc_obj #"test" #"key" undefined () undefined #"a value")
lfe>
```

And then store it in Riak:

```cl
lfe> (lric:put pid obj)
ok
```

Now let's get it back out of Riak:

```cl
lfe> (set `#(ok ,result) (lric:get pid my-bucket key))
#(ok
  #(riakc_obj
    #"test"
    #"key"
    #B(107 206 97 96 96 96 204 96 202 5 82 60 202 156 255 126 62 191 180 112 62 3 243 247 133 25 ...)
    (#(#(dict 2 16 16 8 80 48
         #(() () () () () () () () () () () () () () () ...)
         #(#(() () () () () () () () () () ((#"X-Riak-VTag" ...)) () () ...)))
       #"a value"))
    undefined undefined))
```

That's the complete Riak object; how do we get just the value? Simply
call the appropriate object function:

```cl
lfe> (lrico:get-value result)
#"a value"
```

## Documentation

For more usage examples, see the following docs (all of which are
being ported by Billo from the [Basho
originals](http://docs.basho.com/riak/latest/)):

 * [Taste of Riak](http://billo.gitbooks.io/lfe-taste-of-riak/content/index.html)
 * The Little Riak Book (TBD)
 * Basic Usage (TBD)
 * Riak Search (TBD)
 * Riak Data Types (TBD)
