(defmodule unit-lric-util-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest -replace-dash
  (is-equal "has_dash" (lric-util:-replace-dash "has-dash"))
  (is-equal "has_underscore" (lric-util:-replace-dash "has_underscore"))
  (is-equal "neither" (lric-util:-replace-dash "neither")))

(deftest replace-dash-string
  (is-equal "has_dash" (lric-util:replace-dash "has-dash"))
  (is-equal "has_underscore" (lric-util:replace-dash "has_underscore"))
  (is-equal "neither" (lric-util:replace-dash "neither")))

(deftest replace-dash-atom
  (is-equal 'has_dash (lric-util:replace-dash 'has-dash))
  (is-equal 'has_underscore (lric-util:replace-dash 'has_underscore))
  (is-equal 'neither (lric-util:replace-dash 'neither)))
