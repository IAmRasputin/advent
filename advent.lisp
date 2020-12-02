;;;; advent.lisp

(in-package #:advent)

(defvar *day-1-input* "input/day1.txt")

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

;; The same thing, but with three.
;; Yeah, I'm using a library to enumerate k-combinations.  Fight me.
(defun day-1-part-2 ()
  (let ((nums (ints-from-file *day-1-input*))
        (target 2020)
        answer)
    (alexandria:map-combinations (lambda (args)
                                   (if (= (apply #'+ args) target)
                                       (setf answer (apply #'* args))))
                                 nums
                                 :length 3)
    answer))
