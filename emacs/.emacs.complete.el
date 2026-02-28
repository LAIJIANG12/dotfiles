(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.1)
  (corfu-quit-at-boundary nil)
  (corfu-separator ?\s)
  :bind (:map corfu-map ("SPC" . corfu-insert-separator))
  :init
  (global-corfu-mode))

(use-package cape
  :ensure t
  :init
  ;; 这种写法更稳健：使用 append 确保它不会干扰到原有的补全源
  (add-to-list 'completion-at-point-functions
               (cape-capf-super
                #'cape-dabbrev
                #'cape-file
                #'cape-keyword
                #'cape-history)))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; 定义切换函数
(defun my/toggle-corfu-completion ()
  "切换 Global Corfu Mode 的开启或关闭。"
  (interactive)
  (if global-corfu-mode
      (progn
        (global-corfu-mode -1)
        (message "Corfu 自动补全已【关闭】"))
    (progn
      (global-corfu-mode 1)
      (message "Corfu 自动补全已【开启】"))))

;;绑定快捷键
(global-set-key (kbd "<f5>") #'my/toggle-corfu-completion)
(global-set-key (kbd "M-p m") #'completion-at-point)
