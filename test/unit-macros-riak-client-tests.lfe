(defmodule unit-macros-riak-client-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")
(include-lib "lric/include/riak-client.lfe")

(deftest generate-api
  (is-equal 'noop (a))
  (is-equal 'noop (b 'thing))
  (is-equal 'noop (c 'another 'thing))
  (is-equal 'noop (d 'and 'another 'thing))
  )

(deftest function-check
  (is (is_function #'a/0))
  (is (is_function #'b/1))
  (is (is_function #'c/2))
  (is (is_function #'d/3))
  )