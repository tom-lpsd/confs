(defalias 'perl-mode 'cperl-mode)

(setq cperl-hairy nil
      cperl-indent-level 4
      cperl-auto-newline nil
      cperl-continued-statement-offset 4
      cperl-close-paren-offset -4
      cperl-indent-parens-as-block t)

(add-hook 'cperl-mode-hook
	  (lambda () (setq indent-tabs-mode nil
			   tab-width nil)))
