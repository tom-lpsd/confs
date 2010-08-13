(require 'clojure-mode)

(defalias 'perl-mode 'cperl-mode)

(setq auto-mode-alist
      (append '(("\\.plx$" . perl-mode)
		("\\.t$"   . perl-mode)
		("\\.cgi$" . perl-mode)
		("\\.pfc$" . lisp-mode)
		("\\.oct$" . octave-mode)
                ) auto-mode-alist))
