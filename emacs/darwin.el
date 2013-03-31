(setq mac-pass-control-to-system nil)
(setq mac-command-key-is-meta t)
(setq ns-command-modifier 'meta)

(dolist (target '(japanese-jisx0208 japanese-jisx0212))
  (set-fontset-font nil target
		    '("Hiragino Maru Gothic Pro" . "iso10646-1")))

(setq face-font-rescale-alist
      '(("^-apple-hiragino.*" . 1.2)
        (".*osaka-bold.*" . 1.2)
        (".*osaka-medium.*" . 1.2)
        (".*courier-bold-.*-mac-roman" . 1.0)
        (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
        (".*monaco-bold-.*-mac-roman" . 0.9)
        ("-cdac$" . 1.3)))

(ignore-errors
  (require 'battery)
  (display-battery-mode t))

