;;;; An LFE wrapper for the erlcloud_s3 module, configured to use Riak CS
;;;; instead of Amazon's S3.
(defmodule lrics
  (export all))

(defun noop ()
  'noop)