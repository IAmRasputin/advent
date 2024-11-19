(in-package :advent/config)

(defvar *session-token-file* #p"~/.config/advent/token")
(defvar *user-cache-dir* #p"~/.cache/advent/")
(defvar *session-token*)

(defun set-config (session-token-file user-cache-dir)
  (setf *session-token-file* (or session-token-file *session-token-file*))
  (setf *user-cache-dir* (or user-cache-dir *user-cache-dir*))
  (with-open-file (s *session-token-file* :if-does-not-exist :error)
    (setf *session-token* (read-line s))))