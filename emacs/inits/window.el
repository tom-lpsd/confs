(defun line-to-top-of-window ()
  (interactive)
  (recenter 0))

(global-set-key (kbd "C-z") #'line-to-top-of-window)

(defun other-window-or-split ()
  (interactive)
  (when (one-window-p) (split-window-vertically))
  (other-window 1))

(global-set-key (kbd "C-t") #'other-window-or-split)