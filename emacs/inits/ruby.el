(rvm-use-default)

(dolist (r '("Rakefile$" "Capfile$" "Gemfile$"))
  (add-to-list 'auto-mode-alist (cons r 'ruby-mode)))
