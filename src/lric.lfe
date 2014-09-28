;;;; An LFE wrapper for the riakc_pb_socket module.
(defmodule lric
  (export all))

(include-lib "lric/include/riak-client.lfe")

(defun noop ()
  'noop)