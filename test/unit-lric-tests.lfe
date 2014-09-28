(defmodule unit-lric-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest function-checks
  (is (is_function #'lric:start-link/2))
  (is (is_function #'lric:stop/1))
  (is (is_function #'lric:get/5))
  (is (is_function #'lric:set-bucket-type/4))
  (is (is_function #'lric:modify-type/5)))

(deftest export-count
  (let* ((chunks (beam_lib:chunks "ebin/lric.beam" '(exports)))
         (exports (proplists:get_value
                    'exports
                       (element 2 (element 2 chunks)))))
    (is-equal 109 (length exports))))
