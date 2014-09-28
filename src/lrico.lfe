;;;; An LFE wrapper for the riakc_obj module.
(defmodule lrico
  (export all))

(include-lib "lric/include/riak-objects.lfe")

(defun noop ()
  'noop)