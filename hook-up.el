;;; hook-up.el --- Boom Boom Boom Boom -*- lexical-binding: t -*-
(eval-when-compile
  (require 'umr))
(require 'miscellaneous)

(defmacro hook-up-make-hook (WHEN PROCEDURE &rest CONTINGENT)
  "Set up a hook to run WHEN PROCEDURE.
    Create variable WHEN-PROCEDURE-hook and assign it the value CONTINGENT.
    Create function WHEN-PROCEDURE-hook to run WHEN PROCEDURE-hook using `run-hooks'.
    Use `advice-add' to add run-WHEN-PROCEDURE-hook as advice to PROCEDURE."
  (declare (indent 2))
  (umr-let
   hook (misc--symb WHEN "-" PROCEDURE "-hook")
   `(progn
      (defvar ,hook ',CONTINGENT
        ,(misc--mkstr "procedures to run " WHEN " `" PROCEDURE "'"))
      (defun ,hook (&rest _)
        ,(misc--mkstr "Use `run-hooks' to run `" hook "'.")
        (run-hooks ',hook))
      (advice-add ',PROCEDURE ,WHEN #',hook
                  '((name . ,hook)
                    (depth . -100))))))

(defun hook-up (HOOKS FUNCTIONS)
  "Hang all FUNCTIONS, in order, on all HOOKS."
  (seq-doseq (h HOOKS)
    (seq-doseq (f (seq-reverse FUNCTIONS))
      (add-hook h f))))


(provide 'hook-up)
