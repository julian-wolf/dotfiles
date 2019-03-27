;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")))

(add-hook 'text-mode-hook 'auto-fill-mode)

(setq inferior-lisp-program "sbcl")
(load (expand-file-name "~/quicklisp/slime-helper.el"))

(desktop-save-mode t)

(setq-default indent-tabs-mode nil)

(setq slime-contribs '(slime-fancy))
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

(global-set-key (kbd "C-x g") 'magit-status)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (slime org ## utop magit julia-shell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
