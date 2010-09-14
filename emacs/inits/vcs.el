;; (auto-install-from-url "http://svn.apache.org/repos/asf/subversion/trunk/contrib/client-side/emacs/dsvn.el")
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)

;; (install-elisp "http://github.com/byplayer/egg/raw/master/egg.el")
(when (executable-find "git")
  (require 'egg nil t))
