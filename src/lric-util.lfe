(defmodule lric-util
  (export all))

(defun get-lric-version ()
  (lutil:get-app-src-version "src/lric.app.src"))

(defun get-versions ()
  (++ (lutil:get-version)
      `(#(lric ,(get-lric-version)))))

(defun replace-dash (atom)
  (re:replace
    (atom_to_list atom)
    "-"
    "_"
    '(global #(return list))))
