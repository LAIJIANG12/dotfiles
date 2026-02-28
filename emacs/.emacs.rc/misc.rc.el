;;Load the ANSI Color Resolution Library
(require 'ansi-color)

;;Quickly open the file path at the cursor
(global-set-key (kbd "C-x C-g") 'find-file-at-point)

(setq-default inhibit-splash-screen t
	      make-backup-files nil
	      auto-save-default nil
          create-lockfiles nil
	      tab-width 4
	      indent-tabs-mode nil
	      compilation-scroll-output t
	      visible-bell (equal system-type 'windows-nt))

;;Compile buffer shading
(defun rc/colorize-compilation-buffer ()
  (read-only-mode 'toggle)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (read-only-mode 'toggle))
(add-hook 'compilation-filter-hook 'rc/colorize-compilation-buffer)

;;Get the buffer file path
(defun rc/buffer-file-name ()
  (if (equal major-mode 'dired-mode)
      default-directory
    (buffer-file-name)))

;;Windows special emoji characters
(when (eq system-type 'windows-nt)
  (set-fontset-font t 'unicode (font-spec :family "Segoe UI Emoji") nil 'prepend))
(global-set-key (kbd "C-c e") 'emoji-insert)

;;Default PowerShell
(setq shell-file-name "pwsh.exe")
(setq shell-command-switch "-Command")

;;Force all windows to prioritize horizontal splitting
(setq split-height-threshold 0)
(setq split-width-threshold nil)

;;whitespace
;;(global-whitespace-mode t)
;;(global-set-key (kbd "C-c w") 'global-whitespace-mode)
(setq whitespace-style '(face spaces space-mark))
(global-set-key (kbd "<f8>") 'whitespace-mode)

;;Bracket matching
(electric-pair-mode t)
(show-paren-mode 1)
(setq electric-pair-delete-adjacent-pairs nil)

;;hippie-expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev     
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill   
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially 
        try-complete-lisp-symbol
        ))
(global-set-key (kbd "M-/") 'hippie-expand)
(setq hippie-expand-ignore-case t)
(setq hippie-expand-verbose t)

;;EWW
(global-set-key (kbd "C-c w") 'eww)
(global-set-key (kbd "C-c C-o") 'browse-url-at-point)

;;Confirm when you exit Emacs
;;(setq confirm-kill-emacs 'y-or-n-p)

;;Window navigation shortcuts
(windmove-default-keybindings)

;;File copying
(defun rc/put-file-name-on-clipboard ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (rc/buffer-file-name)))
    (when filename
      (kill-new filename)
      (message filename))))

(defun rc/put-buffer-name-on-clipboard ()
  "Put the current buffer name on the clipboard"
  (interactive)
  (kill-new (buffer-name))
  (message (buffer-name)))

(global-set-key (kbd "C-c f") 'rc/put-file-name-on-clipboard)

(defun rc/rgrep-selected (beg end)
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list (point-min) (point-min))))
  (rgrep (buffer-substring-no-properties beg end) "*" (pwd)))

(global-set-key (kbd "C-x p s") 'rc/rgrep-selected)

;;Open the file at the cursor
(global-set-key (kbd "C-c a") 'find-file-at-point)
