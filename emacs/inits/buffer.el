(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer nil))

(defun kill-other-buffer ()
  (interactive)
  (save-window-excursion
    (other-window 1)
    (kill-current-buffer)))

(global-set-key (kbd "C-x C-b") 'buffer-menu)

(defun switch-to-next-buffer ()
  (interactive)
  (let ((next (other-buffer)))
    (bury-buffer nil)
    (switch-to-buffer next)))

(defun switch-to-previous-buffer ()
  (interactive)
  (let ((original-buffer-list (buffer-list)))
    (modify-frame-parameters nil
      (list (cons 'buffer-list (reverse (buffer-list)))))
    (let ((next (other-buffer)))
      (modify-frame-parameters nil
	(list (cons 'buffer-list original-buffer-list)))
      (switch-to-buffer next))))

(global-set-key (kbd "C-x C-n") #'switch-to-next-buffer)
(global-set-key (kbd "C-x C-p") #'switch-to-previous-buffer)
