(require 'cl)

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/site-lisp/skk")
(add-to-list 'load-path "~/.emacs.d/site-lisp/apel")
(add-to-list 'load-path "~/.emacs.d/site-lisp/emu")
(defvar inits-directory "~/.emacs.d/inits")

(require 'auto-install)
(add-to-list 'load-path auto-install-directory)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
(setq ediff-window-setup-function 'ediff-setup-window-plain)

(when (load (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

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
