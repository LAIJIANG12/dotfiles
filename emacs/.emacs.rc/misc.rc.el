(setq ansi-color-for-compilation-mode t)

(setq-default inhibit-splash-screen t
              make-backup-files nil
              auto-save-default nil
              create-lockfiles nil
              tab-width 4
              indent-tabs-mode nil
              compilation-scroll-output t
              visible-bell (equal system-type 'windows-nt)
              )

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
(global-set-key (kbd "M-/") #'hippie-expand)
(setq hippie-expand-ignore-case t)
(setq hippie-expand-verbose nil)

;;; replace-regexp
(global-set-key (kbd "C-c %") 'replace-regexp)

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

(use-package rainbow-mode
  :ensure t
  :hook (prog-mode . rainbow-mode)
  :custom
  (rainbow-html-colors t)
  (rainbow-x-colors nil)
  (rainbow-ansi-colors nil)
  (rainbow-latex-colors nil))
