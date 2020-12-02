;;;; advent.lisp

(in-package #:advent)

(defvar *day-1-input* "~/other/Lisp/advent/input/day1.txt")

(defun ints-from-file (file)
  (mapcar #'parse-integer (uiop:read-file-lines file)))

;; Open day1.txt, find the two numbers whose sum is 2020, and multiply them.
(defun day-1-part-1 ()
  (let ((nums (ints-from-file *day-1-input*))
        (target 2020))
    (labels ((find-sum (lst target)
               (when (listp lst)
                 (let* ((current (first lst))
                        (query (- target current))
                        (others (rest lst)))
                   (if (member query others)
                       (* current query)
                       (find-sum others target))))))
      (find-sum nums target))))

