(in-package #:day-10)

(defvar *input* "input/day10.txt")

(defparameter *adapters* nil)

(defun load-input (file)
  (setf *adapters* (sort (mapcar #'parse-integer (read-lines file)) #'<)))

(load-input *input*)

(defun scan-for-differences (adapters)
  (let ((ones 1) ;; Port -> first adapter
        (threes 1)) ;; Last adapter -> device
    (labels ((scan (lst)
               (unless (= 1 (length lst))
                 (case (- (cadr lst) (car lst))
                   (1 (incf ones))
                   (3 (incf threes)))
                 (scan (cdr lst)))))
      (scan adapters))
    `(,ones . ,threes)))

(defun valid-next (n)
  (list (+ 1 n)
        (+ 2 n)
        (+ 3 n)))


(defun part-1 ()
  (let ((diffs (scan-for-differences *adapters*)))
    (* (car diffs) (cdr diffs))))

