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
  (setf *seat-map* (mapcar #'parse-line (read-lines file))))

(load-seat-map *input*)

(defun seat (seat-map row col)
  (handler-case (nth col (nth row seat-map))
    (type-error (e) (declare (ignore e))
                           nil)))


(defun adjacent-to (seat-map row col)
  (remove-if #'null (mapcar #'seat 
                            (list seat-map
                                  seat-map
                                  seat-map
                                  seat-map
                                  seat-map
                                  seat-map
                                  seat-map
                                  seat-map)
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

(defun next-spot-1 (seat-map row col)
  (let ((current (seat seat-map row col)))
    (cond
      ;; No adjacent seats taken -> occupied
      ((and (eq current 'empty)
            (every (lambda (s) (or
                                 (eq s 'empty)
                                 (eq s 'floor)))
                   (adjacent-to seat-map row col)))
       'taken)
      ;; Four adjacent seats taken -> empty
      ((and (eq current 'taken)
            (<= 4 (count 'taken (adjacent-to seat-map row col))))
       'empty)
      ;; Else, unchanged
      (t current))))

(defun next-1 (seat-map)
  (loop for row below (length seat-map) collect
        (loop for col below (length (car seat-map)) collect (next-spot-1 seat-map row col))))

(defun seats-taken (seat-map)
  (apply #'+ (mapcar (lambda (line)
                       (count 'taken line))
                     seat-map)))

(defun stabilize-1 (seat-map)
  (do* ((current seat-map after)
        (after (next current) (next after)))
      ((equal current after) (seats-taken current))))

(defun part-1 ()
  (stabilize *seat-map*))


