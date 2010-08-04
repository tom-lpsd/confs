;; システムのキーバインドを無視して emacs へ渡す
(setq mac-pass-control-to-system nil)
(setq mac-command-key-is-meta t)

;; モードラインにバッテリー残量を表示
(display-battery-mode t)

(setq default-frame-alist
      (append '((active-alpha . 0.80)
		(alpha . (95 95))
		(inactive-alpha . 0.50)) default-frame-alist))
