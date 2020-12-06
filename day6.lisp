(in-package #:day-6)

(defvar *input* "input/day6.txt")

;; Take a list of strings representing forms, parse each into a list of chars
(defun parse-group (raw-group)
  (mapcar (lambda (f)
            (coerce f 'list))
          raw-group))

(defun load-forms (file)
  (let* ((raw-input (read-file file))
         (groups (split "\\n\\n" raw-input))
         (split-groups (mapcar (lambda (g)
                                 (split "\\n" g))
                               groups)))
    (mapcar #'parse-group split-groups)))

;; list of groups (list of forms (list of chars))
(defparameter *forms* (load-forms *input*))

(defun collected-answers (grp)
  (length (reduce #'union grp)))

(defun shared-answers (grp)
  (length (reduce #'intersection grp)))

(defun part-1 ()
  (reduce #'+ (mapcar #'collected-answers *forms*)))

(defun part-2 ()
  (reduce #'+ (mapcar #'shared-answers *forms*)))
