;;;; package.lisp

(defpackage #:advent/cmd
  (:use #:cl)
  (:nicknames :cmd)
  (:export :root-command :*cmd*))

(defpackage #:advent/util
  (:use #:cl)
  (:nicknames :util)
  (:export :load-session-token :*session-token-file* :get-from-cache :save-to-cache))

(defpackage #:advent/api
  (:use #:cl)
  (:nicknames :api)
  (:export #:aoc-get-input))

(defpackage #:advent/prompt
  (:use #:cl)
  (:nicknames :prompt)
  (:export #:prompt/command))

(defpackage #:advent/input
  (:use #:cl)
  (:nicknames :input)
  (:export #:input/command))

(defpackage #:advent
  (:use #:cl)
  (:export :main))
