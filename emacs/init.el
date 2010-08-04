(require 'cl)

(add-to-list 'load-path "~/.emacs.d")
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

(let* ((el-regexp "^[^.].*\\.elc?$")
       (inits (mapcar #'car (directory-files-and-attributes
			     inits-directory t el-regexp))))
  (dolist (init (sort (mapcar #'file-name-remove-extension inits) #'string<))
    (load init nil t nil)))

(when (string-match "darwin" system-configuration)
  (load "darwin" nil t nil))
