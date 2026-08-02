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
(defun rc/buffer-file-name ()
  (if (derived-mode-p 'dired-mode)
      default-directory
    (buffer-file-name)))

(defun rc/put-file-name-on-clipboard ()
  (interactive)
  (if-let ((filename (rc/buffer-file-name)))
      (progn
        (kill-new filename)
        (message "%s" filename))
    (message "None")))

(defun rc/put-buffer-name-on-clipboard ()
  (interactive)
  (let ((name (buffer-name)))
    (kill-new name)
    (message "%s" name)))

(defun rc/kill-autoloads-buffers ()
  (interactive)
  (let ((killed-count 0))
    (dolist (buffer (buffer-list))
      (when (string-suffix-p "-autoloads.el" (buffer-name buffer))
        (kill-buffer buffer)
        (setq killed-count (1+ killed-count))))
    (message "Clear buffer zone:%d" killed-count)))

(global-set-key (kbd "C-c z") #'rc/put-file-name-on-clipboard)
(global-set-key (kbd "C-c b") #'rc/put-buffer-name-on-clipboard)

(use-package rainbow-mode
  :ensure t
  :hook (prog-mode . rainbow-mode)
  :custom
  (rainbow-html-colors t)
  (rainbow-x-colors nil)
  (rainbow-ansi-colors nil)
  (rainbow-latex-colors nil))
