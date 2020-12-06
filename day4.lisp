(in-package #:day-4)

(defvar *input* "input/day4.txt")

(defun read-passports-from-file (file)
  (split "\\n\\n" (read-file file)))

(defparameter *passports* nil)

(defun load-passports (file)
  (setf *passports* (mapcar #'parse-passport (read-passports-from-file file))))

;; To convert the string keys into symbols, which suck less
(defun key-symb (key)
  (cond
    ((string= key "byr") :byr)
    ((string= key "iyr") :iyr)
    ((string= key "eyr") :eyr)
    ((string= key "hgt") :hgt)
    ((string= key "hcl") :hcl)
    ((string= key "ecl") :ecl)
    ((string= key "pid") :pid)
    ((string= key "cid") :cid)
    (t (error "Invalid key: ~A~%" key))))

(defun parse-passport (passport)
  (let* ((string-tokens (split "\\n| " passport)))
    (mapcar #'parse-token string-tokens)))

(defun parse-token (token)
  (destructuring-bind (keystring value) (split ":" token)
    (cons (key-symb keystring) value)))
 
;; Sticking this at the top level so it refreshes the value when I re-load the package, and not every time I access it
(load-passports *input*)

(defun has-all-fields-p (passport)
  (every (lambda (fld) (assoc fld passport))
         '(:byr :iyr :eyr :hgt :hcl :ecl :pid)))

(defun verify-year (str minimum maximum)
  (let ((parsed (parse-integer str :junk-allowed t)))
    (and
      parsed
      (numberp parsed)
      (<= minimum parsed maximum))))

(defun valid-prop-p (key val)
  (labels ((verify-year (minimum maximum)
             (let ((parsed (parse-integer val)))
               (and
                 parsed
                 (numberp parsed)
                 (<= minimum parsed maximum))))
           (verify-height ()
             (unless (< (length val) 2)
                 (let* ((unit (subseq val (- (length val) 2))))
                   (cond
                     ((string= unit "in") (and
                                            (numberp (parse-integer val :junk-allowed t))
                                            (<= 59 (parse-integer val :junk-allowed t) 76)))
                     ((string= unit "cm") (and
                                            (numberp (parse-integer val :junk-allowed t))
                                            (<= 150 (parse-integer val :junk-allowed t) 193)))
                     (t nil)))))
           (verify-hair-color ()
             (and
               (= (length val) 7)
               (char= (char val 0) #\#)
               (every (lambda (c)
                        (or
                          (<= 48 (char-code c) 57)
                          (<= 97 (char-code c) 102)))
                      (subseq val 1))))
           (verify-eye-color ()
             (member val '("amb" "blu" "brn" "gry" "grn" "hzl" "oth") :test #'string=))
           (verify-passport-id ()
             (and 
               (= (length val) 9)
               (every (lambda (c) (<= (char-code #\0) 
                                      (char-code c) 
                                      (char-code #\9)))
                      val))))
    (case key
      (:byr (verify-year 1920 2002))
      (:iyr (verify-year 2010 2020))
      (:eyr (verify-year 2020 2030))
      (:hgt (verify-height))
      (:hcl (verify-hair-color))
      (:ecl (verify-eye-color))
      (:pid (verify-passport-id))
      (:cid t))))

(defun valid-passport-p (passport)
  (and
    (has-all-fields-p passport)
    (every (lambda (prop)
             (valid-prop-p (car prop) (cdr prop)))
           passport)))

(defun part-1 ()
  (if *passports*
      (count-if #'has-all-fields-p *passports*)
      (error "You gotta call LOAD-PASSPORTS first~%")))
  
(defun part-2 ()
  (if *passports*
      (count-if #'valid-passport-p *passports*)
      (error "You gotta call LOAD-PASSPORTS first~%")))
