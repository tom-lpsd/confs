(require 'cl)

(add-to-list 'load-path "~/.emacs.d")
(defvar inits-directory "~/.emacs.d/inits")

(defun file-name-remove-extension (name)
  (replace-regexp-in-string "\\(.*\\)\\.[^.]*$" "\\1" name))

(let* ((el-regexp "^[^.].*\\.elc?$")
       (inits (mapcar #'car (directory-files-and-attributes
			     inits-directory t el-regexp))))
  (dolist (init (sort (mapcar #'file-name-remove-extension inits) #'string<))
    (load init nil t nil)))

(require 'auto-install)
(add-to-list 'load-path auto-install-directory)
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
(setq ediff-window-setup-function 'ediff-setup-window-plain)

(when (load (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;;; 以下 Emacs テクニックバイブル p.59 より

;;; gcを減らす
(setq gc-cons-threshold (* 10 gc-cons-threshold))

;;; ログの記録行数を増やす
(setq message-log-max 10000)

;;; ミニバッファを再帰的に呼び出せるようにする
(setq enable-recursive-minibuffers t)

;;; ダイアログボックスを使わないようにする
(setq use-dialog-box nil)
(defalias 'message-box 'message)

;;; 履歴の保存数を増やす
(setq history-length 1000)

;;; キーストロークをエコーエリアに早く表示する
(setq echo-keystrokes 0.1)

;;; 大きいファイルを開くときの警告の閾値を上げる
(setq large-file-warning-threshold (* 25 1024 1024))

;;; ミニバッファで入力を取り消しても履歴に残す
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))
