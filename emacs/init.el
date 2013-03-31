(add-to-list 'load-path "~/.emacs.d")

(display-time)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(line-number-mode 1)
(column-number-mode 1)
(transient-mark-mode 1)
(show-paren-mode 1)
(global-hl-line-mode 1)
(fringe-mode 0)

(defun other-window-or-split ()
  (interactive)
  (when (one-window-p) (split-window-vertically))
  (other-window 1))

(defun kill-backward-dwim ()
  (interactive)
  (if mark-active
    (kill-region (mark) (point))
    (backward-kill-word 1)))

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer nil))

(defun increase-font-size ()
  (interactive)
  (set-face-attribute
   'default
   nil
   :height (ceiling (* 1.10
		       (face-attribute 'default :height)))))

(defun decrease-font-size ()
  (interactive)
  (set-face-attribute
   'default
   nil
   :height (floor (* 0.9
		     (face-attribute 'default :height)))))

(defun line-to-top-of-window ()
  (interactive)
  (recenter 0))

(global-set-key (kbd "C-h") #'delete-backward-char)
(global-set-key (kbd "C-'") #'kill-current-buffer)
(global-set-key (kbd "C-t") #'other-window-or-split)
(global-set-key (kbd "C-x C-x") #'execute-extended-command)
(global-set-key (kbd "C-w") #'kill-backward-dwim)
(global-set-key (kbd "C-+") #'increase-font-size)
(global-set-key (kbd "C--") #'decrease-font-size)
(global-set-key (kbd "C-z") #'line-to-top-of-window)

(windmove-default-keybindings)

(setq backup-inhibited t)
(setq history-length 1000)
(setq kill-ring-max 100)

(recentf-mode)
(setq recentf-max-saved-items 3000)

(require 'package)
(setq package-user-dir (locate-user-emacs-file "packages/elpa"))
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

(setq enable-recursive-minibuffers t)

(global-set-key (kbd "C-]") #'helm-mini)
(global-set-key (kbd "C-x b") #'helm-buffers-list)

(cond ((eq system-type 'gnu/linux)(load "linux"))
      ((eq system-type 'darwin) (load "darwin")))
