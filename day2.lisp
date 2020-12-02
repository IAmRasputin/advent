(in-package #:day-2)

(defvar *input* "input/day2.txt")

;; Parses the string to return the range, character, and password string in a list
;; Example: '((1 5) #\c "passwordString")
(defun parse-password (str)
  (let ((elements (cl-ppcre:split "-| |: " str)))
    (list
      (list (parse-integer (first elements)) (parse-integer (second elements)))
      (coerce (third elements) 'character)
      (fourth elements))))

(defun passwords-from-input (file)
  (mapcar #'parse-password (uiop:read-file-lines file)))

(defun valid-password-p (pass)
  (destructuring-bind ((min max) char str) pass
    (>= max (count char str) min)))
    
(defun part-1 ()
  (length (remove-if #'null (mapcar #'valid-password-p
                                    (passwords-from-input *input*)))))

