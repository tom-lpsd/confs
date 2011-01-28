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

(defun move-to-next-empty-line ()
  (interactive)
  (let ((next (save-excursion
		(forward-char)
		(search-forward-regexp "^$" nil t))))
    (when next (goto-char next))))

(defun move-to-prev-empty-line ()
  (interactive)
  (let ((prev (save-excursion
		(backward-char)
		(search-backward-regexp "^$" nil t))))
    (when prev (goto-char prev))))

(define-key global-map (kbd "C->") #'move-to-next-empty-line)
(define-key global-map (kbd "C-<") #'move-to-prev-empty-line)