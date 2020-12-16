(in-package #:day-10)

(defvar *input* "input/day10.txt")

(defparameter *adapters* nil)

(defun load-input (file)
  (setf *adapters* (sort (mapcar #'parse-integer (read-lines file)) #'<)))

(load-input *input*)

(defun device-rating ()
  (+ 3 (apply #'max *adapters*)))

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

(defun adapters-from (val)
  (nthcdr (position val *adapters*) *adapters*))

(defun part-1 ()
  (let ((diffs (scan-for-differences *adapters*)))
    (* (car diffs) (cdr diffs))))

(defparameter *path-cache* (make-hash-table :test #'equal))

;; oof
(defun part-2 ()
  (labels ((paths-from (adapters)
             (let ((memo (gethash adapters *path-cache*)))
               (if memo
                   memo
                   (let ((paths (apply #'+ (let* ((cur (car adapters))
                                                  (next (valid-next cur)))
                                             (mapcar (lambda (a)
                                                       (cond
                                                         ((= (device-rating) a) 1)
                                                         ((member a *adapters*) (paths-from (adapters-from a)))
                                                         (t 0)))
                                                     next)))))
                     (setf (gethash adapters *path-cache*) paths))))))
    (paths-from (cons 0 *adapters*))))




