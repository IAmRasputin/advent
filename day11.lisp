(in-package :day-11)

(defvar *input* "input/day11.txt")

(defparameter *seat-map* nil)

(defun parse-spot (spot)
  (ecase spot
    (#\L 'empty)
    (#\. 'floor)
    (#\# 'taken)))

(defun parse-line (linestring)
  (make-array (length linestring)
              :initial-contents (mapcar #'parse-spot (coerce linestring 'list))))

(defun load-seat-map (file)
  (setf *seat-map* (let ((lines (read-lines file)))
                     (make-array (list (length lines) (length (car lines)))
                                 :initial-contents (mapcar #'parse-line lines)))))

(load-seat-map *input*)

(defun seat (row col)
  (handler-case (aref *seat-map* row col)
    (sb-int:invalid-array-index-error (e) (declare (ignore e)) nil)))

(defun adjacent-to (row col)
  (remove-if #'null (mapcar #'seat 
                            (list (1+ row)
                                  (1+ row)
                                  (1+ row)
                                  row
                                  row
                                  (- row 1)
                                  (- row 1)
                                  (- row 1))
                            (list (1+ col)
                                  col
                                  (- col 1)
                                  (1+ col)
                                  (- col 1)
                                  (1+ col)
                                  col
                                  (- col 1)))))

(defun next-spot (row col)
  (let ((current (aref *seat-map* row col)))
    (cond
      ((and (eq current 'empty)
            (every (lambda (s) (or
                                 (eq s 'empty)
                                 (eq s 'floor)))
                   (adjacent-to row col)))
       'taken)

      ((and (eq current 'taken)
            (<= 4 (count 'taken (adjacent-to row col))))
       'empty)

      ((eq current 'floor) 'floor)

      (t current))))


(defun next (seat-map)
  (let* ((dimensions (array-dimensions seat-map))
         (rows (car dimensions))
         (cols (cadr dimensions))
         (next (make-array dimensions)))
    (loop for row below rows do
          (loop for col below cols do
                (setf (aref next row col) (next-spot row col))))
    next))

