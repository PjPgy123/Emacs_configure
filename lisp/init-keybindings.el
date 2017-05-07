
;;smex快捷键绑定
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
;;C-s 搜索候补项

;;swiper快捷键绑定


;; 利用快捷键 f2 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "C:/Emacs25.1/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-init-file)

(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;;利用y和n 替代 yes 和no
(fset 'yes-or-no-p 'y-or-n-p)

;;查找函数、变量、快捷键的定义
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

;; 代码缩进 C-M \
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

;;hippie 补全y
(global-set-key (kbd "M-/") 'hippie-expand)

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(global-set-key (kbd "M-s e") 'iedit-mode)

;;swiper
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)

;;切换TAB空格数目
(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)

;;js2-refactor
(js2r-add-keybindings-with-prefix "C-c C-m")

(global-set-key (kbd "M-s i") 'counsel-imenu)

(global-set-key (kbd "C-=") 'er/expand-region)


(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c r") 'org-capture)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))



(provide 'init-keybindings)
