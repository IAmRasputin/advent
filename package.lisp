;;;; package.lisp

(defpackage #:advent-utils
  (:use #:cl)
  (:export #:read-file #:read-lines #:xor #:while))

(defpackage #:day-1
  (:use #:cl #:advent-utils)
  (:export #:part-1 #:part-2))

(defpackage #:day-2
  (:use #:cl #:advent-utils #:cl-ppcre)
  (:export #:part-1 #:part-2))

(defpackage #:day-3
  (:use #:cl #:advent-utils)
  (:export #:part-1 #:part-2))

(defpackage #:day-4
  (:use #:cl #:advent-utils #:cl-ppcre)
  (:export #:part-1 #:part-2))

