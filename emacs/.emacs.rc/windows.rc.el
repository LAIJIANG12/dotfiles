;;; Default PowerShell
;; (setq shell-file-name "pwsh.exe")
;; (setq shell-command-switch "-Command")
;; (setq w32-quote-process-args t)
;; (with-eval-after-load 'comint
;;   (define-key comint-mode-map (kbd "C-c l") 'comint-clear-buffer))


(defun my-open-external-terminal-pwsh ()
  (interactive)
  (let ((dir (expand-file-name (if (buffer-file-name) (file-name-directory (buffer-file-name)) default-directory))))
    (w32-shell-execute "open" "pwsh.exe" (concat "-WorkingDirectory \"" dir "\""))))

(global-set-key (kbd "C-c r") #'my-open-external-terminal-pwsh)

;;; Invoke the software
(defun open-firefox ()
    (interactive)
    (call-process "C:\\Program Files\\Mozilla Firefox\\firefox.exe" nil 0))
