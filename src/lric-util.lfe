(defmodule lric-util
  (export all))

(defun get-lric-version ()
  (lutil:get-app-src-version "src/lric.app.src"))

(defun get-versions ()
  (++ (lutil:get-version)
      `(#(lric ,(get-lric-version)))))

(defun -replace-dash (item)
  (re:replace item "-" "_" '(global #(return list))))

(defun replace-dash
  ((item) (when (is_list item))
    (-replace-dash item))
  ((item) (when (is_atom item))
    (list_to_atom (-replace-dash (atom_to_list item)))))
