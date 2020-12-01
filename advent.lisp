;;;; advent.lisp

(in-package #:advent)

(defvar *day-1-input* "~/other/Lisp/advent/input/day1.txt")

;; Open day1.txt, find the two numbers whose sum is 2020, and multiply them.
(defun day-1-part-1 ()
  (let ((nums (mapcar #'parse-integer (uiop:read-file-lines *day-1-input*)))
        (target 2020))
    (labels ((find-sum (lst)
               (cond
                 ((or (atom lst) (null lst)) nil)
                 (t (let* ((cur (first lst))
                           (query (- target cur))
                           (others (rest lst)))
                      (if (member query others)
                          (* cur query)
                          (find-sum others)))))))
      (find-sum nums))))
