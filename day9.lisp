(in-package #:day-9)

(defvar *input* "input/day9.txt")

(defun load-ints (file)
  (mapcar #'parse-integer (read-lines file)))

(defparameter *ints* (load-ints *input*))

(defun valid-num (preamble num)
  (unless (> 2 (length preamble))
    (if (member (- num (car preamble)) (cdr preamble))
        t
        (valid-num (cdr preamble) num))))

(defun scan-for-error (code)
  (if (>= (length code) 26)
      (do* ((result nil)
            (test-index 25 (1+ test-index))
            (test-val (nth test-index code) (nth test-index code))
            (preamble (subseq code (- test-index 25) test-index)
                      (subseq code (- test-index 25) test-index)))
          ((or (>= test-index (length code)) result) result)
       (unless (valid-num preamble test-val)
         (setf result test-val))))) 

;; Man, DO is kinda ugly but super powerful.  If I was ever
;; going to use this code again, I'd have a reason to hide it in a macro
(defun sum-from-sequence (nums target)
  (unless (null nums)
    (do* ((end 1 (1+ end))
          (sub (subseq nums 0 end) (subseq nums 0 end))
          (sum (apply #'+ sub) (apply #'+ sub)))
        ((or (= target sum) 
             (> (1+ end) (length nums)))
         (if (= target sum)
             (+ (apply #'min sub) (apply #'max sub))
             (sum-from-sequence (cdr nums) target))))))


(defun part-2 ()
  (let ((invalid-num (part-1)))
    (sum-from-sequence *ints* invalid-num)))

(defun part-1 ()
  (scan-for-error *ints*))
