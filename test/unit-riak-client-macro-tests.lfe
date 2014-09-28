(defmodule unit-riak-client-macro-tests
  (behaviour ltest-unit)
  (export all)
  (import
    (from ltest
      (check-failed-assert 2)
      (check-wrong-assert-exception 2))))

(include-lib "ltest/include/ltest-macros.lfe")
(include-lib "lric/include/riak-client.lfe")

(deftest placeholder
  (is-equal 1 1))
