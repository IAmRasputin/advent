(in-package :advent/util)

(defun cache-path (cache-name path)
  (format nil 
          "~a/~a/~a" 
          config:*user-cache-dir*
          (string-downcase (symbol-name cache-name)) 
          path))

(defun load-session-token ()
  (with-open-file (s config:*session-token-file* :if-does-not-exist :error)
    (read-line s)))

(defun get-from-cache (cache-name path)
  (let ((cache (cache-path cache-name path)))
    (if (uiop:file-exists-p cache)
        (uiop:read-file-string cache)
        (format t "file ~a does not exist~%" cache))))   

(defun save-to-cache (cache-name path data)
  (let ((cache (cache-path cache-name path)))
    (ensure-directories-exist cache)
    (with-open-file (c cache :if-exists :overwrite :if-does-not-exist :create :direction :output)
      (format c "~a" data))))

(defun next-unsolved (year)
  (let* ((results-page (api:aoc-get-frontpage year))
         (dom (lquery:$ (initialize results-page)))
         (all-done (length (lquery:$ dom ".calendar .calendar-verycomplete")))
         (half-done (length (lquery:$ dom ".calendar .calendar-complete"))))
    (list (1+ all-done) (1+ half-done))))

(defun most-recent-year-day-part ()
  "Get the most-recent year/day pair for which you have an unsolved puzzle."
  (multiple-value-bind (s mi h d mo y)
      (get-decoded-time)
    (declare (ignorable s mi h d mo))
    (let ((year (if (= mo 12) y (- y 1))))
      (append (list year) (next-unsolved year)))))

(defun parse-date-args (arg-string)
  "Take in an arg-string of the form `YYYY DD`, `DD YYYY` or similar, and parse a normalized date"
  (let* ((arg-split (uiop:split-string arg-string))
         (year-arg (find-if (lambda (x) (= (length x) 4)) arg-split))
         (day-arg (find-if (lambda (x) (or 
                                         (= (length x) 1)
                                         (= (length x) 2)))
                           arg-split)))
    (cons (or year-arg
              (first (most-recent-year-day-part)))
          (or day-arg
              (second (most-recent-year-day-part))))))

(get-decoded-time)
