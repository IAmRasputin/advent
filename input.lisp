(in-package :advent/input)

(defun input (cmd)
  (let* ((day (clingon:getopt cmd :day))
         (year (clingon:getopt cmd :year))
         (pathstring (format nil "~d/~d" year day))
         (response (or (util:get-from-cache :input pathstring)
                       (let ((input (api:aoc-get-input year day)))
                         (util:save-to-cache :input pathstring input)
                         input))))
    (format t "~a" response)
    response))

(defun input/command ()
  (clingon:make-command
    :name "input"
    :description "Get puzzle input"
    :handler #'input))
