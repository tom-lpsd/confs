;; (install-elisp "http://github.com/jochu/clojure-mode/raw/master/clojure-mode.el")
(require 'clojure-mode)

(defalias 'perl-mode 'cperl-mode)
(setq indent-tabs-mode nil
      cperl-hairy nil
      cperl-indent-level 4
      cperl-auto-newline nil
      cperl-continued-statement-offset 4
      cperl-close-paren-offset -4
      cperl-indent-parens-as-block t)

(defun force-space-indent ()
  (setq indent-tabs-mode nil)
  (setq tab-width nil))

(add-hook 'cperl-mode-hook #'force-space-indent)

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'font-lock-mode)

(setq auto-mode-alist
      (append '(("\\.plx$" . perl-mode)
		("\\.t$"   . perl-mode)
		("\\.cgi$" . perl-mode)
		("\\.pfc$" . lisp-mode)
		("\\.oct$" . octave-mode)
                ) auto-mode-alist))
