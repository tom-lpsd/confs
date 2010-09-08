(autoload 'riece "riece" "IRC client" t)
(add-hook 'riece-command-mode-hook
	  (lambda ()
	    (define-key riece-command-mode-map
	      (kbd "C-c C-k") 'riece-command-previous-channel)))
