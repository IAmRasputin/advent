(in-package :day-11)

(defvar *input* "input/day11.txt")

(defparameter *seat-map* nil)

(defun parse-spot (spot)
  (ecase spot
    (#\L 'empty)
    (#\. 'floor)
    (#\# 'taken)))

(defun parse-line (linestring)
  (mapcar #'parse-spot (coerce linestring 'list)))

(defun load-seat-map (file)
  (setf *seat-map* (let ((lines (read-lines file)))
                     (make-array (list (length lines) (length (car lines)))
                                 :initial-contents (mapcar #'parse-line lines)))))

(defun seat (row col)
  (handler-case (aref *seat-map* row col)
    (sb-int:invalid-array-index-error (e) (declare (ignore e)) nil)))

(load-seat-map *input*)

