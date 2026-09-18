(require 'ansi-color)
(add-hook 'compilation-filter-hook #'ansi-color-compilation-filter)

(setq-default inhibit-splash-screen t
              make-backup-files nil
              auto-save-default nil
              create-lockfiles nil
              tab-width 4
              indent-tabs-mode nil
              compilation-scroll-output t
              )

;;; Force all windows to prioritize horizontal splitting
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;;; hippie-exp
(use-package hippie-exp
  :bind ("M-/" . hippie-expand)
  :config
  (setq hippie-expand-try-functions-list
        '(try-expand-dabbrev
          try-expand-dabbrev-all-buffers
          try-complete-file-name-partially
          try-complete-file-name
          try-expand-dabbrev-from-kill
          try-complete-lisp-symbol-partially  
          try-complete-lisp-symbol      
          try-expand-all-abbrevs        
          try-expand-list               
          try-expand-line))                

  (setq hippie-expand-ignore-case t
        hippie-expand-verbose nil))

;;; replace-regexp
(global-set-key (kbd "C-c %") 'replace-regexp)

;; Window navigation shortcuts
(windmove-default-keybindings 'super)

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

;;; #Color
(use-package rainbow-mode
  :ensure t
  :hook (prog-mode . rainbow-mode)
  :custom
  (rainbow-html-colors t)
  (rainbow-x-colors nil)
  (rainbow-ansi-colors nil)
  (rainbow-latex-colors nil))
