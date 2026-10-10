(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(package-initialize)

(setq custom-file "~/.emacs.custom.el")

;;; load,load-file
(load "~/.emacs.rc/rc.el")
(load "~/.emacs.rc/misc.rc.el")

(add-to-list 'load-path "~/.emacs.local/")

(rc/require-theme 'gruber-darker)

;;; Relative line number
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;;; Font
;; (set-face-attribute 'default nil :height 120)
(add-to-list 'default-frame-alist `(font . "Iosevka-18")) ; Iosevka
(set-fontset-font t 'han (font-spec :family "MiSans Regular" :weight 'normal))

;;; Dired
(setq dired-dwim-target t)

;;; top-bottom split
(setq split-height-threshold 0)

;;; simpc-mode
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;;; ido
(ido-mode 1)
(ido-everywhere 1)

(rc/require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; multiple cursors
(rc/require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;;; yasnippet
(rc/require 'yasnippet)

(require 'yasnippet)

(setq yas/triggers-in-field nil)
(setq yas-snippet-dirs '("~/.emacs.snippets/"))

(yas-global-mode 1)

;;; Copy cursor content
(defun rc/duplicate-line ()
  "Duplicate current line"
  (interactive)
  (let ((column (- (point) (line-beginning-position)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(global-set-key (kbd "C-,") 'rc/duplicate-line)

;;; Enable global automatic bracket completion
(show-paren-mode 1)
(setq show-paren-delay 0)

;;; Paredit
(rc/require 'paredit)

(defun rc/turn-on-paredit ()
  (interactive)
  (paredit-mode 1))

(add-hook 'emacs-lisp-mode-hook  'rc/turn-on-paredit)
(add-hook 'clojure-mode-hook     'rc/turn-on-paredit)
(add-hook 'lisp-mode-hook        'rc/turn-on-paredit)
(add-hook 'common-lisp-mode-hook 'rc/turn-on-paredit)
(add-hook 'scheme-mode-hook      'rc/turn-on-paredit)
(add-hook 'racket-mode-hook      'rc/turn-on-paredit)

;;; Company
(rc/require 'company)
(require 'company)

(global-company-mode)

(add-hook 'tuareg-mode-hook
          (lambda ()
            (interactive)
            (company-mode 0)))

;;; Whitespace mode(M-x customize-group RET whitespace RET whitespace-style)
(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

(add-hook 'tuareg-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c++-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'simpc-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'emacs-lisp-mode 'rc/set-up-whitespace-handling)
(add-hook 'java-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'lua-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'rust-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'scala-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'markdown-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'haskell-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'python-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'erlang-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'asm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'fasm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'go-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'nim-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'yaml-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'porth-mode-hook 'rc/set-up-whitespace-handling)

(global-set-key (kbd "<f8>") 'whitespace-mode)

;;; tranp
(setq tramp-auto-save-directory (locate-user-emacs-file "tramp"))

;; right-click on the word "fixme" in a comment
;; for next-error support:
;; M-x fixmee-view-listing RET
(use-package button-lock :ensure t)
(use-package fixmee
  :ensure t
  :config
  (global-fixmee-mode 1))

;;; Packages that don't require configuration
(rc/require
 'markdown-mode
 'go-mode
 'csharp-mode
 'cmake-mode
 'qml-mode
 'rfc-mode
 'js2-mode
 'elpy
 'fsharp-mode
 'json-mode
)

(add-to-list 'auto-mode-alist '("\\.\\(sh\\|bash\\|zsh\\)\\'" . sh-mode))

(setq font-lock-maximum-decoration t)

(load-file custom-file)
