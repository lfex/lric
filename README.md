# lric

[![Build Status][travis badge]][travis]
[![LFE Versions][lfe badge]][lfe]
[![Erlang Versions][erlang badge]][versions]
[![Tags][github tags badge]][github tags]
[![Downloads][hex downloads]][hex package]

[![][project-logo]][project-logo-large]

*Riak & Riak CS client wrappers for LFE*


## Contents

* [Introduction](#introduction-)
* [Installation](#installation-)
* [Usage](#usage-)
* [Documentation](#documentation-)
* [License](#license-)


## Introduction [&#x219F;](#contents)

Mostly because the module names of the Erlang Riak client are a bit
cumbersome. And not Lispy.


## Installation [&#x219F;](#contents)

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


## Usage [&#x219F;](#contents)

Below is a quick sample from the Riak docs converted to LFE and
lric. First, let's start up the LFE REPL:

```
$ lfe
Erlang/OTP 19 [erts-8.2.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] ...

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


## Documentation [&#x219F;](#contents)

For more usage examples, see the following docs (all of which are
being ported by Billo from the [Basho
originals](http://docs.basho.com/riak/latest/)):

 * [Taste of Riak](http://billo.gitbooks.io/lfe-taste-of-riak/content/index.html)
 * The Little Riak Book (TBD)
 * Basic Usage (TBD)
 * Riak Search (TBD)
 * Riak Data Types (TBD)


## License [&#x219F;](#contents)

Apache License, Version 2.0

Copyright © 2014-2017, BilloSystems, Ltd. Co.

Copyright © 2017, Ricardo Lanziano

Copyright © 2017, Duncan McGreggor


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
