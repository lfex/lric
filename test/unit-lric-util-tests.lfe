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

(deftest append-integer-string
  (is-equal "a1" (lric-util:append-integer "a" 1))
  (is-equal "abc1" (lric-util:append-integer "abc" 1))
  (is-equal "abc100" (lric-util:append-integer "abc" 100))
  (is-equal "abc1001" (lric-util:append-integer "abc" 1001))
  (is-equal "abc1" (lric-util:append-integer "abc" 001)))

(deftest append-integer-atom
  (is-equal 'a1 (lric-util:append-integer 'a 1))
  (is-equal 'abc1 (lric-util:append-integer 'abc 1))
  (is-equal 'abc100 (lric-util:append-integer 'abc 100))
  (is-equal 'abc1001 (lric-util:append-integer 'abc 1001))
  (is-equal 'abc1 (lric-util:append-integer 'abc 001)))

(deftest append-integer-integer
  (is-equal "11" (lric-util:append-integer 1 1))
  (is-equal "2001" (lric-util:append-integer 200 1))
  (is-equal "200100" (lric-util:append-integer 200 100))
  (is-equal "2001001" (lric-util:append-integer 200 1001))
  (is-equal "21" (lric-util:append-integer 002 001)))

(deftest make-args
  (is-equal '() (lric-util:make-args 0))
  (is-equal '(arg-1) (lric-util:make-args 1))
  (is-equal '(arg-1 arg-2) (lric-util:make-args 2))
  (is-equal '(arg-1 arg-2 arg-3 arg-4) (lric-util:make-args 4)))

(deftest make-func
  (is-equal
    '(defun my-func-name () 'noop)
    (lric-util:make-func '(my-func-name 0)))
  (is-equal
    '(defun my-func-name (arg-1) 'noop)
    (lric-util:make-func '(my-func-name 1)))
  (is-equal
    '(defun my-func-name (arg-1 arg-2) 'noop)
    (lric-util:make-func '(my-func-name 2))))

(deftest make-funcs
  (is-equal
    '((defun func-y () 'noop)
      (defun func-y (arg-1) 'noop)
      (defun func-y (arg-1 arg-2) 'noop))
    (lric-util:make-funcs '((func-y 0) (func-y 1) (func-y 2)))))