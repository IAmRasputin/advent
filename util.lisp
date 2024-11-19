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
