;; (install-elisp-from-emacswiki "point-undo.el")
(require 'point-undo)
(define-key global-map (kbd "<f7>") 'point-undo)
(define-key global-map (kbd "S-<f7>") 'point-redo)

;;Shiftカーソルでウィンドウ間移動．
(windmove-default-keybindings)

(defun kill-backward-dwim ()
  (interactive)
  (if mark-active
    (kill-region (mark) (point))
    (backward-kill-word 1)))

(define-key global-map (kbd "C-w") #'kill-backward-dwim)
