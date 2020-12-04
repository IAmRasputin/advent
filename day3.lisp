(in-package :day-3)

(defvar *input* "input/day3.txt")

(defvar *map*)

;; Absolutely wild that this isn't in the standard, if you ask me
(defmacro while (pred &body body)
  `(do ()
       ((not ,pred))
     ,@body))

(defun load-map (file)
  (unless *map*
    (setf *map* (let ((lines (uiop:with-safe-io-syntax ()
                               (uiop:read-file-lines *input*))))
                  lines))))

(defun tile-at (row-index col-index)
  (if *map*
      (let ((row (nth row-index *map*)))
        (char row (mod col-index (length row))))
      (error "Load the map first, ya dingus")))

(defun trees-with-slope (slope)
  (let ((row 0)
        (col 0)
        (tree-count 0))
    (load-map *input*)
    (while (> (length *map*) row)
      (when (char= #\# (tile-at row col))
        (incf tree-count))
      (incf row (car slope))
      (incf col (cadr slope)))
    tree-count))

(defun part-1 ()
  (trees-with-slope '(1 3)))

(defun part-2 ()
  (apply #'*
         (mapcar #'trees-with-slope
                 '((1 1) (1 3) (1 5) (1 7) (2 1)))))
