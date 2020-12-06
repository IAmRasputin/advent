(in-package #:advent-utils)

(defun read-file (file)
  (uiop:with-safe-io-syntax ()
    (uiop:read-file-string file)))

(defun read-lines (file)
  (uiop:with-safe-io-syntax ()
    (uiop:read-file-lines file)))

(defun xor (clause-x clause-y)
  (or (and clause-x (not clause-y))
      (and clause-y (not clause-x))))

;; Absolutely wild that this isn't in the standard, if you ask me
(defmacro while (pred &body body)
  `(do ()
       ((not ,pred))
     ,@body))
