(require 'cl)

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/skk")
(add-to-list 'load-path "~/.emacs.d/site-lisp/apel")
(add-to-list 'load-path "~/.emacs.d/site-lisp/emu")
(add-to-list 'load-path "~/.emacs.d/site-lisp/magit")
(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme")
(add-to-list 'load-path "~/.emacs.d/site-lisp/ddskk/lisp/skk")
(defvar inits-directory "~/.emacs.d/inits")

(require 'auto-install)
(add-to-list 'load-path auto-install-directory)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

;; curl -O https://github.com/technomancy/emacs-starter-kit/raw/master/package.el
(when (load (expand-file-name "~/.emacs.d/site-lisp/package.el"))
  (package-initialize)
  (add-to-list 'package-archives
	       '("technomancy" . "http://repo.technomancy.us/emacs/") t))

(defun file-name-remove-extension (name)
  (replace-regexp-in-string "\\(.*\\)\\.[^.]*$" "\\1" name))

(defun load-elisp-directory (dirname)
  (let* ((el-regexp "^[^.].*\\.elc?$")
	 (inits (mapcar #'car (directory-files-and-attributes
			       dirname t el-regexp))))
    (dolist (init (sort (mapcar #'file-name-remove-extension inits) #'string<))
      (load init nil t nil))))

(load-elisp-directory inits-directory)

(case system-type
  ('gnu/linux (load-elisp-directory "~/.emacs.d/linux"))
  ('darwin    (load-elisp-directory "~/.emacs.d/darwin")))

(when (require 'color-moccur nil t)
  (require 'moccur-edit)
  (setq moccur-split-word t)
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "\\.svn")
  (add-to-list 'dmoccur-exclusion-mask "\\.git"))
