;;;; advent.asd

(asdf:defsystem #:advent
  :description "Advent of Code helper functions"
  :author "Ryan Gannon <ryanmgannon@gmail.com>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :build-operation "program-op"
  :build-pathname "advent"
  :entry-point "advent:main"
  :depends-on ("dexador" "clingon" "plump" "lquery")
  :components ((:file "package")
               (:file "cmd")
               (:file "util")
               (:file "api")
               (:file "input")
               (:file "advent")))
