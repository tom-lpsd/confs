(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-x C-m") 'execute-extended-command)
(require 'sequential-command-config)
(sequential-command-setup-keys)

(require 'key-chord)
(setq key-chord-two-keys-delay 0.02)
(key-chord-mode 1)
(key-chord-define-global "kl" #'kill-current-buffer)
(key-chord-define-global "ko" #'kill-other-buffer)
(key-chord-define emacs-lisp-mode-map "df" 'describe-function)
(key-chord-define-global " n" #'switch-to-next-buffer)
(key-chord-define-global " p" #'switch-to-previous-buffer)

(require 'space-chord)
(space-chord-define-global "f" #'find-file)
(space-chord-define-global "j" #'toggle-input-method)
(space-chord-define-global "s" #'svn-status)

(defadvice toggle-input-method (around toggle-input-method-around activate)
  (let ((input-method-function-save input-method-function))
    ad-do-it
    (setq input-method-function input-method-function-save)))

(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)
