(in-package :advent/api)

(defvar *base-url* "https://adventofcode.com")

(defun aoc-get (url-fmt &rest url-args)
  (let ((cookie (format nil "session=~a" (config:get-session-token)))
        (based-url (format nil "~a/~a" *base-url* url-fmt)))
    (nth-value 0 
               (dex:get (apply #'format 
                               nil 
                               based-url
                               url-args)
                        :headers (list 
                                   (cons "Cookie" cookie))))))

(defun aoc-get-input (year day)
  (aoc-get "~d/day/~d/input" year day))

(defun aoc-get-prompt (year day)
  (aoc-get "~d/day/~d" year day))

(defun aoc-get-frontpage (year)
  (aoc-get "~d" year))
