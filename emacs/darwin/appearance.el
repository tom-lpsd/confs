;; モードラインにバッテリー残量を表示
(display-battery-mode t)

(setq default-frame-alist
      (append '((active-alpha . 0.80)
		(alpha . (95 95))
		(inactive-alpha . 0.50)) default-frame-alist))

(setq initial-frame-alist
      '((top . 0) (left . 0) (width . 238) (height . 60)
	(font . "-apple-monaco-medium-r-normal--13-130-72-72-m-130-iso10646-1")))
