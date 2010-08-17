(defun browse-url-chrome (url &optional new-window)
  (interactive (browse-url-interactive-arg "URL: "))
  (start-process "google-chrome" nil "google-chrome" url))

(setq browse-url-browser-function 'browse-url-chrome)
