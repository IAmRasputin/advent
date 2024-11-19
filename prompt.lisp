(in-package :advent/prompt)

(defun prompt (year day)
  ;; TODO: Figure out how caching should work if the prompt updates after you
  ;; solve the first puzzle
  (let* ((pathstring (format nil "~d/~d" year day))
         (dom (lquery:$ (initialize (api:aoc-get-prompt year day)))))
    dom))

(defun prompt/handler (cmd)
  (let* ((year (clingon:getopt cmd :year))
         (day (clingon:getopt cmd :day))
         (response (prompt year day)))
    (format t "~s~%" response)
    response))

(defun prompt/command ()
  (clingon:make-command
    :name "prompt"
    :description "get the prompt for a day's puzzle"
    :handler #'prompt/handler))


