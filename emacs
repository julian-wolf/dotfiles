
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-hook 'text-mode-hook 'auto-fill-mode)

(setq inferior-lisp-program "sbcl")
(load (expand-file-name "~/quicklisp/slime-helper.el"))

(desktop-save-mode t)

(add-to-list 'slime-contribs 'slime-repl)

(setq slime-close-parens-limit 16)
(defun slime-close-parens-at-point ()
  "Close parenthesis at point to complete the top-level form. Simply
inserts ')' characters at point until `beginning-of-defun' and
`end-of-defun' execute without errors, or `slime-close-parens-limit'
is exceeded."
  (interactive)
  (loop for i from 1 to slime-close-parens-limit
  until (save-excursion
    (slime-beginning-of-defun)
    (ignore-errors (slime-end-of-defun) t))
  do (insert ")")))

(define-key slime-mode-map (kbd "C-c C-q") 'slime-close-parens-at-point)

(show-paren-mode)

(global-linum-mode t)
(setq linum-format "%3d ")

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/"))

(global-set-key (kbd "C-x g") 'magit-status)

(defun julia-repl ()
  "Runs Julia in a screen session in a `term' buffer."
  (interactive)
  (require 'term)
  (let ((termbuf (apply 'make-term "Julia REPL" "screen"
                        nil (split-string-and-unquote "julia"))))
    (set-buffer termbuf)
    (term-mode)
    (term-char-mode)
    (switch-to-buffer termbuf)))
(global-set-key (kbd "C-x j") 'julia-repl)
