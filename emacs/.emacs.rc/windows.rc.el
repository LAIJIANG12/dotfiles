;;; Default PowerShell
;; (setq shell-file-name "pwsh.exe")
;; (setq shell-command-switch "-c")
;; (setq shell-command-switch "-Command")
(with-eval-after-load 'comint
  (define-key comint-mode-map (kbd "C-c l") 'comint-clear-buffer))

;;; CMD
(defun my-open-external-terminal-cmd ()
  (interactive)
  (let ((dir (expand-file-name (if (buffer-file-name)
                                   (file-name-directory (buffer-file-name))
                                default-directory))))
    (w32-shell-execute "open" "cmd.exe"
                       (concat "/K cd /d " (file-name-as-directory dir)))))
;; (w32-shell-execute "open" "pwsh.exe"
;;                    (concat "-NoExit -Command Set-Location '" dir "'"))

(global-set-key (kbd "C-c t") 'my-open-external-terminal-cmd)


;;; PowerShell
(defun my-open-external-terminal-pwsh ()
  (interactive)
  (let* ((dir (expand-file-name (if (buffer-file-name)
                                   (file-name-directory (buffer-file-name))
                                 default-directory)))
         (win-dir (replace-regexp-in-string "/" "\\" dir t t)))
    (w32-shell-execute "open" "pwsh.exe"
             (concat "-NoExit -Command \"Set-Location -Path '" win-dir "'\""))))

(global-set-key (kbd "C-c r") 'my-open-external-terminal-pwsh)

;;; Invoke the software
(defun firefox.exe ()
    (interactive)
    (call-process "C:\\Program Files\\Mozilla Firefox\\firefox.exe" nil 0))


(defun open-Krita ()
    (interactive)
  (call-process "D:\\Laijiang\\Krita (x64)\\bin\\krita.exe" nil 0))


;;; Specify the location
(setenv "PYTHONUTF8" "1")
(setq python-shell-interpreter "D:/opt/Python/python.exe")
(setq python-shell-pip-command "D:/opt/Python/Scripts/pip.exe")
