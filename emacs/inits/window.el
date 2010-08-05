(defun line-to-top-of-window ()
  (interactive)
  (recenter 0))

(global-set-key (kbd "C-z") 'line-to-top-of-window)
