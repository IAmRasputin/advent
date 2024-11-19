(in-package :advent/input)

(defun input (year day)
  (let ((pathstring (format nil "~d/~d" year day)))
    (or (util:get-from-cache :input pathstring)
        (let ((input (api:aoc-get-input year day)))
          (util:save-to-cache :input pathstring input)
          input))))

(defun input/handler (cmd)
  "Get args from the command object here, so the rest of the API is more lispy"
  (let* ((day (clingon:getopt cmd :day))
         (year (clingon:getopt cmd :year))
         (pathstring (format nil "~d/~d" year day))
         (response (input year day)))
    (format t "~a" response)
    response))

(defun input/command ()
  (clingon:make-command
    :name "input"
    :description "Get puzzle input"
    :handler #'input/handler))
