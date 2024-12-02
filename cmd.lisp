(in-package :advent/cmd)

(defun root-command ()
  (clingon:make-command
    :name "advent"
    :description "do AoC without opening your browser"
    :version "0.0.2"
    :options (list
               (clingon:make-option :filepath
                                    :short-name #\t
                                    :description "The path to the token config file"
                                    :long-name "token"
                                    :env-vars '("ADVENT_SESSION_TOKEN_FILE")
                                    :initial-value config:*session-token-file*
                                    :key :token)) 
    :handler (lambda (cmd)
               (clingon:print-usage-and-exit cmd t))
    :sub-commands (list 
                    (input:input/command)
                    (prompt:prompt/command))))
