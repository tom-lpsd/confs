(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-x C-x") 'execute-extended-command)
(require 'sequential-command-config)
(sequential-command-setup-keys)

(require 'key-chord)
(setq key-chord-two-keys-delay 0.05)
(key-chord-mode 1)
(key-chord-define emacs-lisp-mode-map "df" 'describe-function)
(key-chord-define global-map "mg" 'magit-status)

(defadvice toggle-input-method (around toggle-input-method-around activate)
  (let ((input-method-function-save input-method-function))
    ad-do-it
    (setq input-method-function input-method-function-save)))

(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)
