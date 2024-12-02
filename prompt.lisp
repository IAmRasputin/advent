(in-package :advent/prompt)

(defun prompt (year day)
  "Returns either a string, representing a single day/part prompt, or a list, containing the prompts 
  for both parts of the puzzle."
  ;; TODO: Figure out how caching should work if the prompt updates after you
  ;; solve the first puzzle
  (let* ((dom (lquery:$ (initialize (api:aoc-get-prompt year day))))
         (blocks (lquery-funcs:children (lquery:$ dom "main")))
         (articles (remove-if-not (lambda (b)
                                    (equal (plump:tag-name b) "article"))
                                  blocks)))
    (labels ((render-article (article)
               (let* ((parts (lquery-funcs:children article))
                      (header-element (aref (remove-if-not (lambda (e)
                                                             (equal (plump:tag-name e) "h2"))
                                                           parts)
                                            0))
                      (the-rest (remove-if (lambda (e)
                                             (equal (plump:tag-name e) "h2"))
                                           parts)))
                 (format nil "~a~%~%~{~a~%~%~}~%" 
                         (plump:text header-element)
                         (map 'list #'plump:text the-rest)))))
      (cond
        ((= 2 (length articles)) (list (render-article (aref articles 0))
                                       (render-article (aref articles 1))))
        ((= 1 (length articles)) (render-article (aref articles 0)))
        (t (error "Uh oh!"))))))

(defun prompt/handler (cmd)
  ;; TODO: better options parsing
  (let* ((args (clingon:command-arguments cmd))
         (date (util:parse-date-args args))
         (year (car date))
         (day (cdr date))
         (response (prompt year day)))
    (format t "~a~%" (bobbin:wrap response 80))
    response))

(defun prompt/command ()
  (clingon:make-command
    :name "prompt"
    :description "get the prompt for a day's puzzle"
    :handler #'prompt/handler))


