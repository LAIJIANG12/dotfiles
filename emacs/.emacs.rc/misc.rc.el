;;; Load the ANSI Color Resolution Library
(require 'ansi-color)

(setq-default inhibit-splash-screen t
              make-backup-files nil
              auto-save-default nil
              create-lockfiles nil
              tab-width 4
              indent-tabs-mode nil
              compilation-scroll-output t
              visible-bell (equal system-type 'windows-nt))

;;; Quickly open the file path at the cursor
(defun my-find-file-or-directory-at-point ()
  (interactive)
  (let ((path (ffap-file-at-point)))
    (if path
        (if (file-directory-p path)
            (dired path)
          (find-file path))
      (message "No valid file found at the cursor position/Folder path"))))

(global-set-key (kbd "C-x C-g") 'find-file-at-point)

;;; Compile buffer shading
(defun rc/colorize-compilation-buffer ()
  (read-only-mode 'toggle)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (read-only-mode 'toggle))
(add-hook 'compilation-filter-hook 'rc/colorize-compilation-buffer)

;;; Get the buffer file path
(defun rc/buffer-file-name ()
  (if (equal major-mode 'dired-mode)
      default-directory
    (buffer-file-name)))

;;; Force all windows to prioritize horizontal splitting
(setq split-height-threshold 0)
(setq split-width-threshold nil)

;;; hippie-expand
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

;;; replace-regexp
(global-set-key (kbd "C-c %") 'replace-regexp)

;;; Confirm when you exit Emacs
(setq confirm-kill-emacs 'y-or-n-p)

;; Window navigation shortcuts
(windmove-default-keybindings)

;;; File copying
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

(defun rc/kill-autoloads-buffers ()
  (interactive)
  (dolist (buffer (buffer-list))
    (let ((name (buffer-name buffer)))
      (when (string-match-p "-autoloads.el" name)
        (kill-buffer buffer)
        (message "Killed autoloads buffer %s" name)))))

(global-set-key (kbd "C-c z") 'rc/put-file-name-on-clipboard)
(global-set-key (kbd "C-c b") 'rc/put-buffer-name-on-clipboard)

;;; Open the file at the cursor
(global-set-key (kbd "C-c a") 'find-file-at-point)

;;; Bracket matching
(electric-pair-mode t)
(show-paren-mode t)
(setq electric-pair-delete-adjacent-pairs nil)

;;; Background color
(use-package rainbow-mode
  :ensure t
  :hook (prog-mode . rainbow-mode)
  :config
  (setq rainbow-html-colors t)
  (setq rainbow-x-colors nil)
  (setq rainbow-ansi-colors nil)
  (setq rainbow-latex-colors nil))
