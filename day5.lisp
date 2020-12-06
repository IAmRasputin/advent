(in-package #:day-5)

(defvar *input* "input/day5.txt")

(defun load-passes (file)
  (read-lines *input*))

;; String -> cons pair of BIT VECTORS
(defun parse-pass (pass)
  (let* ((row-str (subseq pass 0 7))
         (col-str (subseq pass 7))
         (row-bits (mapcar (lambda (c)
                             (cond
                               ((char= c #\F) 0)
                               ((char= c #\B) 1)))
                           (coerce row-str 'list)))
         (col-bits (mapcar (lambda (c)
                             (cond
                               ((char= c #\L) 0)
                               ((char= c #\R) 1)))
                           (coerce col-str 'list))))
    (cons (make-array 7 :element-type 'bit :initial-contents row-bits)
          (make-array 3 :element-type 'bit :initial-contents col-bits))))

(defparameter *boarding-passes* (mapcar #'parse-pass (load-passes *input*)))

(defun seat-id (pass)
  (let ((row (int<- (car pass)))
        (col (int<- (cdr pass))))
    (+ (* 8 row) col)))

(defun part-1 ()
  (last (sort (mapcar #'seat-id *boarding-passes*) #'>)))

(defun part-2 ()
  (let* ((seat-ids (sort (mapcar #'seat-id *boarding-passes*) #'<))
         missing)
    (dotimes (cur (length seat-ids))
      (unless (member (+ cur (car seat-ids)) seat-ids)
        (setf missing (+ cur (car seat-ids)))))
    missing))
