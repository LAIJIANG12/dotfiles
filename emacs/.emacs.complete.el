(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)                 ; 开启自动补全
  (corfu-auto-prefix 2)          ; 输入 2 个字符后弹出
  (corfu-preselect 'prompt)      ; 禁止预选
  (corfu-auto-delay 0.1)         ; 弹出延迟（秒），0.1秒感觉最跟手
  (corfu-quit-at-boundary 'separator) ; 遇到空格自动关闭
  (corfu-cycle t)                ; 列表循环滚动
  :init
  (global-corfu-mode))           ; 全局开启

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))
(use-package cape
  :ensure t
  :init
  
  ;; 添加补全源
  (add-to-list 'completion-at-point-functions #'cape-dabbrev) ; 补全当前 Buffer 的词
  (add-to-list 'completion-at-point-functions #'cape-file)    ; 补全路径/文件名
  (add-to-list 'completion-at-point-functions #'cape-keyword)) ; 补全 C 语言关键字
  (add-to-list 'completion-at-point-functions #'cape-history) ; 历史记录补全
