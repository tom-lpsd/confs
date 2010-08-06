(global-set-key (kbd "C-h") 'delete-backward-char)

(require 'sticky)
(use-sticky-key ";" sticky-alist:en)

(require 'sequential-command-config)
(sequential-command-setup-keys)

(require 'key-chord)
(setq key-chord-two-keys-delay 0.04)
(key-chord-mode 1)
(key-chord-define emacs-lisp-mode-map "df" 'describe-function)

(require 'space-chord)
(space-chord-define-global "f" 'find-file)
(space-chord-define-global "j" 'toggle-input-method)

(defadvice toggle-input-method (around toggle-input-method-around activate)
  (let ((input-method-function-save input-method-function))
    ad-do-it
    (setq input-method-function input-method-function-save)))
