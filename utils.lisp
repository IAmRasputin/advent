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

(defun group (source n)
  (if (zerop n) (error "Zero length"))
  (labels ((rec (source acc)
             (let ((rest (nthcdr n source)))
               (if (consp rest)
                   (rec rest (cons (subseq source 0 n) acc))
                   (nreverse (cons source acc))))))
    (if source (rec source nil) nil)))
