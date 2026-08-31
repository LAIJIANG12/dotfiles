(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(package-initialize)

(setq custom-file "~/.emacs.custom.el")

;;; load,load-file
(load "~/.emacs.rc/rc.el")
(load "~/.emacs.rc/misc.rc.el")
(load "~/.emacs.rc/windows.rc.el")

(add-to-list 'load-path "~/.emacs.local/")

(rc/require-theme 'gruber-darker)

;;; Relative line number
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; (add-hook 'prog-mode-hook #'display-line-numbers-mode)
;; (add-hook 'text-mode-hook #'display-line-numbers-mode)

(defun rc/toggle-relative-line-numbers ()
  (interactive)
  (setq-local display-line-numbers-type 'relative)
  (display-line-numbers-mode 'toggle))

(global-set-key (kbd "<f9>") 'rc/toggle-relative-line-numbers)

;;; Font
;; (set-face-attribute 'default nil :height 120)
(add-to-list 'default-frame-alist `(font . "Iosevka-15")) ; Iosevka
(set-fontset-font t 'han (font-spec :family "Sarasa Gothic CL" :weight 'normal))

;;; Dired
(setq dired-dwim-target t)

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

;;; Copy cursor content
(defun rc/duplicate-line ()
  "Duplicate current line"
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(global-set-key (kbd "C-,") 'rc/duplicate-line)

;;; Rainbow Delimiters
(rc/require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;; Enable global automatic bracket completion
(electric-pair-mode 1)

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

;;; Emacs lisp
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-j")
                            (quote eval-print-last-sexp))))
(add-to-list 'auto-mode-alist '("Cask" . emacs-lisp-mode))

;;; magit
;; magit requres this lib, but it is not installed automatically on
;; Windows.
(rc/require 'cl-lib)
(rc/require 'magit)

(setq magit-auto-revert-mode nil)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)

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

(setq whitespace-style
      '(face
        trailing
        tabs
        spaces
        lines
        indentation
        space-after-tab
        space-mark
        tab-mark))

(global-set-key (kbd "<f8>") 'whitespace-mode)

;;; tranp
(setq tramp-auto-save-directory (locate-user-emacs-file "tramp"))

;;; Fixme list:fixmee-view-listing (TODO,FIXME,BUG,HACK,XXX)
(use-package button-lock :ensure t)
(use-package fixmee :ensure t)
(global-fixmee-mode 1)

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

(load-file custom-file)
