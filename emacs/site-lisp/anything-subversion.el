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
  (with-current-buffer (get-buffer-create url)
    (save-excursion
      (call-process svn-program nil t t "cat" url))
    (if (re-search-forward "^svn: warning:.*refers to a directory$" nil t)
	(progn
	  (kill-buffer nil)
	  nil)
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
	(anything-other-buffer
	 '(anything-subversion) (concat "*anything subversion:" url "*"))))))

(setq anything-subversion
      '((name . "anything subversion repositories")
	(init . (lambda ()
		  (with-current-buffer (anything-candidate-buffer 'global)
		    (dolist (url anything-subversion-repository-urls)
		      (anything-subversion-list url)))))
	(candidates-in-buffer)
	(action ("Open" . anything-subversion-open))))

;; (anything 'anything-subversion)

(provide 'anything-subversion)
