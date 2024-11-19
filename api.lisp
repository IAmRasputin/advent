(in-package :advent/api)

(defvar *base-url* "https://adventofcode.com")

(defun aoc-get-input (year day)
  (nth-value 0 
             (dex:get (format nil "~a/~d/day/~d/input" *base-url* year day)
                      :headers (list 
                                 (cons "Cookie" 
                                       (format nil "session=~a" config:*session-token*))))))

(defun aoc-get-prompt (year day)
  (nth-value 0 
             (dex:get (format nil "~a/~d/day/~d" *base-url* year day)
                      :headers (list 
                                 (cons "Cookie" 
                                       (format nil "session=~a" config:*session-token*))))))
