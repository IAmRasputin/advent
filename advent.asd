;;;; advent.asd

(asdf:defsystem #:advent
  :description "Advent of Code 2020"
  :author "Ryan Gannon <ryan.gannon@trinetx.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:alexandria)
  :components ((:file "package")
               (:file "day1")
               (:file "day2")))
