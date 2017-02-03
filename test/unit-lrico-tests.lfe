(defmodule unit-lrico-tests
  (behaviour ltest-unit))

(include-lib "ltest/include/ltest-macros.lfe")

(defun get-test-file ()
  "./_build/test/lib/lric/ebin/lrico.beam")

(deftest function-checks
  (is (is_function #'lrico:new/2))
  (is (is_function #'lrico:new/3))
  (is (is_function #'lrico:new/4))
  (is (is_function #'lrico:vclock/1))
  (is (is_function #'lrico:get-value/1))
  (is (is_function #'lrico:set-user-metadata-entry/1))
  (is (is_function #'lrico:add-link/2)))

(deftest export-count
  (let* ((chunks (beam_lib:chunks (get-test-file) '(exports)))
         (exports (proplists:get_value
                    'exports
                       (element 2 (element 2 chunks)))))
    (is-equal 48 (length exports))))
