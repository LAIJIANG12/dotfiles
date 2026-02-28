(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(setq custom-file "~/.emacs.custom.el")
(package-initialize)

;;load(智能加载) load-file(强制加载)
(load "~/.emacs.rc/rc.el")
(load "~/.emacs.rc/misc.rc.el")
(load "~/.emacs.complete.el")

(rc/require-theme 'gruber-darker)
(column-number-mode 1)
(size-indication-mode 1)
;;Global line number display
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

;;添加自定义目录到 Emacs 的加载路径
(add-to-list 'load-path "~/.emacs.local/")

;;simpc-mode
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;;设置中文字体
(set-fontset-font t 'han (font-spec :family "HarmonyOS Sans SC"));;SimSun
;;字体
(add-to-list 'default-frame-alist `(font . "Iosevka-14")) ;;Iosevka

;;(.c)=gbk
(modify-coding-system-alist 'file "\\.c\\'" 'gbk)

;;Close the current buffer
(global-set-key (kbd "C-x k") 'kill-buffer)

;;Toggle buffers
(global-set-key (kbd "C-<tab>") 'next-buffer)
(global-set-key (kbd "C-S-<tab>") 'previous-buffer)

;;开启自动保存光标位置功能
(save-place-mode 1)
;;(默认在 .emacs.d/places)
(setq save-place-file (concat user-emacs-directory "places"))

;;ido
(ido-mode 1)
(ido-everywhere 1)

(rc/require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;;multiple cursors
(rc/require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;;Copy cursor content
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

;;; magit
;; magit requres this lib, but it is not installed automatically on
;; Windows.
(rc/require 'cl-lib)
(rc/require 'magit)

(setq magit-auto-revert-mode nil)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)

(load-file custom-file)
