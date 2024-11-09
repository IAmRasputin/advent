; Copyright © 2024 Ryan Gannon <ryanmgannon.dev@gmail.com>
; 
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
; 
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
; 
; You should have received a copy of the GNU General Public License
; along with this program. If not, see <http://www.gnu.org/licenses/>.

(in-package #:advent)

(defvar *session-token-file* #p"~/.config/advent/token")

(defun advent (cmd)
  (let ((token-file (or (clingon:getopt cmd :token-file)
                        *session-token-file*)))
    (with-open-file (s token-file :if-does-not-exist :error)
      (format t "~s~%" (read-line s)))))

(defun advent-cli-cmd ()
  (clingon:make-command
    :name "advent"
    :description "do AoC without opening your browser"
    :version "0.0.1"
    :options (list
               (clingon:make-option :filepath
                                    :short-name #\c
                                    :long-name "config-file"
                                    :env-vars '("ADVENT_SESSION_TOKEN_FILE")
                                    :key :token-file))
    :handler #'advent))

(defun main ()
  (let ((app (advent-cli-cmd)))
    (clingon:run app)))

