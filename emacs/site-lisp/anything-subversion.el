(require 'view)
(require 'dsvn)
(require 'anything)

(defgroup anything-subversion nil
  "groups for `anything-subversion'"
  :group 'anything)

(defcustom anything-subversion-repository-urls nil
  "Your project's subversion repository urls"
  :type '(repeat string)
  :group 'anything-subversion)

(defun anything-subversion-cat (url)
  (interactive "sURL: ")
  (with-current-buffer (get-buffer-create url)
    (save-excursion
      (call-process svn-program nil t t "cat" url))
    (if (or (re-search-forward "^svn: warning:.*refers to a directory$" nil t)
	    (re-search-forward "^svn: 警告: URL .* はディレクトリを指しています$" nil t))
	(progn (kill-buffer nil) nil)
      (switch-to-buffer (current-buffer)))))

(defun anything-subversion-list (url)
  (set-mark (point))
  (call-process svn-program nil t t "list" url)
  (string-insert-rectangle (mark) (point) url))

(defun anything-subversion-open (url)
  (unless (anything-subversion-cat url)
    (if anything-in-persistent-action
	(progn
	  (switch-to-buffer (get-buffer-create url))
	  (anything-subversion-list url))
      (let ((anything-subversion-repository-urls (list url)))
	(anything-subversion)))))

(defvar anything-c-source-subversion
      '((name . "anything subversion repositories")
	(init . (lambda ()
		  (with-current-buffer (anything-candidate-buffer 'global)
		    (dolist (url anything-subversion-repository-urls)
		      (anything-subversion-list url)))))
	(candidates-in-buffer)
	(action ("Open" . anything-subversion-open))))

(defun anything-subversion ()
  (interactive)
  (anything-other-buffer '(anything-c-source-subversion)
			 "*anything subversion*"))

(provide 'anything-subversion)
