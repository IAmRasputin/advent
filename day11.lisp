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

;; Part 1

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


(defun next-spot (seat-map row col)
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

(defun next (seat-map)
  (loop for row below (length seat-map) collect
        (loop for col below (length (car seat-map)) collect (next-spot seat-map row col))))

(defun seats-taken (seat-map)
  (apply #'+ (mapcar (lambda (line)
                       (count 'taken line))
                     seat-map)))

(defun stabilize (seat-map)
  (do* ((current seat-map after)
        (after (next current) (next after)))
      ((equal current after) (seats-taken current))))

(defun part-1 ()
  (stabilize *seat-map*))

;; Part 2

(defun up-from (seat-map row col)
  (loop for row-index from row downto 0 
        collect (seat seat-map row-index col)))

(defun upright-from (seat-map row col)
  (loop for row-index from row downto 0
        for col-index from col below (length (car seat-map))
        collect (seat seat-map row-index col-index)))

(defun right-from (seat-map row col)
  (cdr (loop for col-index from col below (length (car seat-map))
             collect (seat seat-map row col-index))))

(defun downright-from (seat-map row col)
  (cdr (loop for row-index from row below (length seat-map)
             for col-index from col below (length (car seat-map))
             collect (seat seat-map row-index col-index))))
  
(defun down-from (seat-map row col)
  (cdr (loop for row-index from row below (length seat-map)
             collect (seat seat-map row-index col))))

(defun downleft-from (seat-map row col)
  (cdr (loop for row-index from row below (length seat-map)
             for col-index from col downto 0
             collect (seat seat-map row-index col-index))))

(defun left-from (seat-map row col)
  (cdr (loop for col-index from col downto 0
             collect (seat seat-map row col))))

(defun upleft-from (seat-map row col)
  (cdr (loop for row-index from row downto 0
             for col-index from col downto 0
             collect (seat seat-map row-index col-index))))

(defun in-direction (seat-map row col direction)
  (ecase direction
    (up (up-from seat-map row col))
    (up-right (upright-from seat-map row col))
    (right (right-from seat-map row col))
    (down-right (downright-from seat-map row col))
    (down (down-from seat-map row col))
    (down-left (downleft-from seat-map row col))
    (left (left-from seat-map row col))
    (up-left (upleft-from seat-map row col))))

(defun first-seat (view)
  (car (remove 'floor view)))

(defun in-view (seat-map row col)
  (remove nil (mapcar #'first-seat (list
                                     (in-direction seat-map row col 'up)
                                     (in-direction seat-map row col 'up-left)
                                     (in-direction seat-map row col 'left)
                                     (in-direction seat-map row col 'down-left)
                                     (in-direction seat-map row col 'down)
                                     (in-direction seat-map row col 'down-right)
                                     (in-direction seat-map row col 'right)
                                     (in-direction seat-map row col 'up-right)))))

(defun spot-after (seat-map row col)
  (if (eq 'floor (seat seat-map row col))
      'floor
      (let ((seen (in-view seat-map row col)))
        (cond
          ((<= 5 (count 'taken seen)) 'empty)
          ((zerop (count 'taken seen)) 'taken)
          (t (seat seat-map row col))))))

(defun next-2 (seat-map)
  (loop for row below (length seat-map) collect
        (loop for col below (length (car seat-map)) collect
              (spot-after seat-map row col))))

(defun stabilize-2 (seat-map)
  (do* ((current seat-map after)
        (after (next-2 current) (next-2 after)))
      ((equal current after) (seats-taken current))))

(defun day-2 ()
  (stabilize-2 *seat-map*))

(day-2) ;; too low?
