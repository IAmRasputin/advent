(in-package :advent/cmd)

(defvar *cmd* nil)

(defun root-command ()
  (setf *cmd* (clingon:make-command
                :name "advent"
                :description "do AoC without opening your browser"
                :version "0.0.2"
                :options (list
                           (clingon:make-option :filepath
                                                :short-name #\t
                                                :description "The path to the token config file"
                                                :long-name "token"
                                                :env-vars '("ADVENT_SESSION_TOKEN_FILE")
                                                :initial-value util:*session-token-file*
                                                :key :token)
                           (clingon:make-option :integer
                                                :short-name #\y
                                                :description "The year to query"
                                                :long-name "year"
                                                :env-vars '("ADVENT_YEAR")
                                                :initial-value (nth-value 5 (get-decoded-time))
                                                :key :year)
                           (clingon:make-option :integer
                                                :short-name #\d
                                                :description "The day to query"
                                                :long-name "day"
                                                :env-vars '("ADVENT_DAY")
                                                :initial-value (nth-value 3 (get-decoded-time))
                                                :key :day)) 
                :handler (lambda (cmd)
                           (clingon:print-usage-and-exit cmd t))
                :sub-commands (list 
                                (input:input/command)))))
