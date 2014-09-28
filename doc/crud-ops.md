# lric : A Taste of Riak

*CRUD Operations*


## Prerequisites

To do this tutorial, you will need the following:

* Erlang.
* The Riak database, installed and running on a system.
* The lric wrapper library (see the README of this project for installation
  instructions).


## CRUD Operations


### Connecting to Riak

```bash
$ make repl-no-deps
...
LFE Shell V6.2 (abort with ^G)
>
```

Let's connect to our database Riak server:

```cl
> (set `#(ok ,pid) (lric:start-link "127.0.0.1" 8087))
#(ok <0.32.0>)
```


### Creating Objects in Riak

```cl
> (set my-bucket (binary "test"))
#B(116 101 115 116)
> (set key-1 (binary "key 1"))
#B(107 101 121 32 49)
> (set value-1 (binary "a value for key 1"))
#B(97 32 118 97 108 117 101 32 102 ...)
```

With these in place, we can create an object:

```cl
> (set obj-1 (lrico:new my-bucket key-1 value-1))
#(riakc_obj
  #B(116 101 115 116)
  #B(107 101 121 32 49)
  undefined
  ()
  undefined
  #B(97 32 118 97 108 117 101 32 102 ...))
```

and then store it in Riak:

```cl
> (lric:put pid obj-1)
ok
```

If we're not storing string values, we can skip the ``(binary ...)`` call:

```cl
> (set key-2 (binary "key 2"))
#B(107 101 121 32 50)
> (set value-2 2)
2
> (set obj-2 (lrico:new my-bucket key-2 value-2))
#(riakc_obj ...)
> (lric:put pid obj-2)
ok
```

We can also store more complicated data structures:

```cl
> (set key-3 (binary "key 3"))
#B(107 101 121 32 50)
> (set value-3 `#(value ,(binary "7 times 6")))
#(value #B(55 32 116 105 109 101 115 32 54))
> (set obj-3 (lrico:new my-bucket key-3 value-3))
#(riakc_obj ...)
> (lric:put pid obj-3)
ok
```


### Reading Objects from Riak

The following will return a Riak object data structure:

```cl
> (set `#(ok ,result) (lric:get pid my-bucket key-1))
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

To get the value from that data structure:

```cl
> (binary_to_term (lrico:get-value result))
"a value"
```

We can, of course, do it all in one shot:

```cl
> (binary_to_term
    (lrico:get-value
      (element 2 (lric:get pid my-bucket key-2))))
2
```


### Updating Objects in Riak

Let's give the kv-pair we stored in ``value-3`` a new associated value:

```cl
> (set new-value-3 (setelement 2 value-3 42))
#(value 42)
```

Now we can update the kv-pair stored in Riak:

```cl
> (set `#(ok ,result) (lric:get pid my-bucket key-3))
#(ok ...)
> (set updated-obj-3 (lrico:update-value result new-value-3))
#(riakc_obj ...)
>  (set `#(ok ,new-result) (lric:put pid updated-obj-3 '(return_body)))
#(ok ...)
```

Let's verify:

```cl
> (binary_to_term (lrico:get-value new-result))
#(value 42)
```


### Deleting Objects from Riak

Couldn't be simpler:

```cl
> (lric:delete pid my-bucket key-1)
ok
> (lric:delete pid my-bucket key-2)
ok
```

And then to confirm:

```cl
> (lric:get pid my-bucket key-1)
#(error notfound)
> (lric:get pid my-bucket key-2)
#(error notfound)
```


### Working with Complex Objects

TBD


There's more to the tutorial!

 * <a href="doc/querying.md">A Taste of Querying</a>
 * <a href="doc/obj-model.md">Object Modeling</a>
