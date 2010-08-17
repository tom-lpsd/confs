(require 'anything-startup)
(global-set-key (kbd "C-]") #'anything)
(global-set-key (kbd "C-x b") #'anything-buffers+)
(define-key anything-map (kbd "C-h") 'delete-backward-char)
