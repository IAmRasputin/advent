;;;; advent.asd

(asdf:defsystem #:advent
  :description "Advent of Code 2020"
  :author "Ryan Gannon <ryan.gannon@trinetx.com>"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:alexandria #:bit-smasher)
  :components ((:file "package")
               (:file "utils")
               (:file "day1")
               (:file "day2")
               (:file "day3")
               (:file "day4")
               (:file "day5")
               (:file "day6")
               (:file "day7")
               (:file "day8")
               (:file "day9")))
