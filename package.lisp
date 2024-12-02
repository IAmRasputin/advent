;;;; package.lisp
(defpackage #:advent/config
  (:use #:cl)
  (:nicknames :config)
  (:export :set-config :get-session-token :*session-token-file*  :*user-cache-dir* :*session-token*))

(defpackage #:advent/cmd
  (:use #:cl)
  (:nicknames :cmd)
  (:export :root-command))

(defpackage #:advent/util
  (:use #:cl)
  (:nicknames :util)
  (:export :load-session-token :get-from-cache :save-to-cache :most-recent-year-day-part :parse-date-args))

(defpackage #:advent/api
  (:use #:cl)
  (:nicknames :api)
  (:export #:aoc-get-input #:aoc-get-prompt #:aoc-get-frontpage))

(defpackage #:advent/prompt
  (:use #:cl)
  (:nicknames :prompt)
  (:export #:prompt/command #:prompt))

(defpackage #:advent/input
  (:use #:cl)
  (:nicknames :input)
  (:export #:input/command #:input))

(defpackage #:advent
  (:use #:cl)
  (:export :main))
