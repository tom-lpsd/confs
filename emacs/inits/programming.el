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

(setq auto-mode-alist
      (append '(("\\.plx$" . perl-mode)
		("\\.t$"   . perl-mode)
		("\\.cgi$" . perl-mode)
		("\\.pfc$" . lisp-mode)
		("\\.oct$" . octave-mode)
                ) auto-mode-alist))
