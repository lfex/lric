(defmodule unit-lric-tests
  (behaviour ltest-unit))

(include-lib "ltest/include/ltest-macros.lfe")

(defun get-test-file ()
  "./_build/test/lib/lric/ebin/lric.beam")

(deftest function-checks
  (is (is_function #'lric:start-link/2))
  (is (is_function #'lric:stop/1))
  (is (is_function #'lric:get/5))
  (is (is_function #'lric:set-bucket-type/4))
  (is (is_function #'lric:modify-type/5)))

(deftest export-count
  (let* ((chunks (beam_lib:chunks (get-test-file) '(exports)))
         (exports (proplists:get_value
                    'exports
                       (element 2 (element 2 chunks)))))
    (is-equal 111 (length exports))))
