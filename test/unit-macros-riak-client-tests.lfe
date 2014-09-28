(defmodule unit-macros-riak-client-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")
(include-lib "lric/include/riak-client.lfe")

(deftest generate-api
  (is-equal 'noop (a))
  ; (is-equal 'noop (b))
  ; (is-equal 'noop (c))
  (is-equal 'noop (b 'thing))
  (is-equal 'noop (c 'another 'thing))
  )
