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

;; C-(, C-)で対応括弧にジャンプ
(defun move-to-match-parenthesis (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (if (looking-at-p "\\s(")
    (forward-list)
    (unless (bobp)
      (when (save-excursion (backward-char) (looking-at-p "\\s)"))
	  (backward-list)))))

(global-set-key (kbd "C-(") 'move-to-match-parenthesis)
(global-set-key (kbd "C-)") 'move-to-match-parenthesis)
