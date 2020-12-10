(in-package #:day-7)

(defvar *input* "input/day7.txt")

;; Wrangle that string into a list of symbols
(defun parse-rule (rulestring)
  (let* ((words (split " " rulestring))
         (stripped (remove-if (lambda (word)
                                (member word '("contains"
                                               "contain"
                                               "no"
                                               "other"
                                               "bag"
                                               "bags"
                                               "bag,"
                                               "bags,"
                                               "bag."
                                               "bags.") :test #'string=))
                              words))
         (key (read-from-string (format nil "~a-~a" (first stripped) (second stripped))))
         (contents (group (nthcdr 2 stripped) 3))
         (parsed-contents (mapcar (lambda (c)
                                    (cons (read-from-string (format nil "~a-~a" (second c) (third c)))
                                          (read-from-string (first c))))
                                  contents)))
    `(,key . ,@parsed-contents)))

(defun load-rules (file)
  (let ((rules (mapcar #'parse-rule (read-lines file)))
        (table (make-hash-table)))
    (dolist (rule rules table)
      (setf (gethash (car rule) table) (cdr rule)))))


(defvar *rules* (load-rules *input*))

;; Does candidate contain query?  If candidate == query => NIL
(defun contains (candidate query)
  (unless (eq candidate query)
    (or (some (lambda (c)
                (eq (car c) query))
              (gethash candidate *rules*))
        (some (lambda (c)
                (contains (car c) query))
              (gethash candidate *rules*)))))

;; Starting at ROOT in *rules*, what's the sum of all contained bags, recursively?
(defun bag-sum (root)
  (let ((contents (gethash root *rules*)))
    (if (null contents)
        0
        (apply #'+
               (mapcar (lambda (sub-bag)
                         (let ((color (first sub-bag))
                               (num (second sub-bag)))
                           (1+ (* num (bag-sum color)))))
                       contents)))))

(defun part-1 ()
  (let ((valid 0))
    (maphash (lambda (k v)
               (declare (ignore v))
               (when (contains k 'shiny-gold)
                   (incf valid)))
             *rules*)
    valid))

(defun part-2 ()
  (bag-sum 'shiny-gold))
