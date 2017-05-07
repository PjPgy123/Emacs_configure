;; cl - Common Lisp Extension
(require 'cl)

;;加载Package开始
;;(when (>= emacs-major-version 24)
;;(add-to-list 'package-archives '("melpa" . "http://stable.melpa.org/packages/") t))
;;替换为国内镜像
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))


;; Add Packages
(defvar my/packages '(
                      ;; --- Auto-completion ---
                      company
                      ;; --- Better Editor ---
                      hungry-delete
                      ;;优化M-x
                      smex
		      ;;
		      swiper
		      ;;
		      counsel
                      ;;括号自动补全
                      smartparens
                      ;; --- Majsor Mode ---
                      js2-mode
                      ;; --- Minor Mode ---
                      nodejs-repl
                      ;;
                      exec-path-from-shell
                      ;;光标移动到新打开的窗口
                      popwin
                      ;; --- Themes ---
                      monokai-theme
                      ;; solarized-theme
                      ;;html开发
                      web-mode
                      ;;重构js2
                      js2-refactor
		      ;;
		      expand-region
		      ;;
		      iedit
		      ;;
		      pt
		      ;;
		      flycheck
		      ;;代码块补全
		      yasnippet
		      ;;
		      auto-yasnippet
		      ;;
		      evil
		      ;;
		      window-numbering
		      ;;
		      evil-leader
		      ;;利用powerline-evil显示窗口号，powerline
		      ;;powerline
		      ;;
		      evil-surround
		      ;;
		      evil-nerd-commenter
		      ;;
		      powerline-evil
		      ;;
		      which-key
		      ;;
		      use-package
                      ) "Default packages")
(setq package-selected-packages my/packages)

(defun my/packages-installed-p ()
  (loop for pkg in my/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))
(unless (my/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg my/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))
;;加载Package结束


;;开启全局 Company 补全
(global-company-mode 1)

;;加载hungry-delete
(require 'hungry-delete)
(global-hungry-delete-mode)

;;配置 smex
(require 'smex)
(smex-initialize)
;;key-bindings

;;配置swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)


;;配置smartparens
(smartparens-global-mode t)
(sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)

;;配置js2-mode
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

;;配置 nodejs-repl 执行java
(require 'nodejs-repl)

;;配置exec-path-from-shell
(require 'exec-path-from-shell) ;; if not using the ELPA package
;;(exec-path-from-shell-initialize)

;;配置popwin
(require 'popwin)
(popwin-mode t)

;;自动加载选定的monokai主题
(load-theme 'monokai' t)

;;abrev-mode 用户自定义补全
(abbrev-mode t)
;;配置在init-better-default


;;配置web-mode
;;用web-mode打开html文件
(setq auto-mode-alist
      (append
       '(("\\.html\\'" . web-mode))
       auto-mode-alist))
;;配置缩进
;; 1.初始2个空格
(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)
;; 2. 在2和4个空格间切换
(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
        (setq js-indent-level (if (= js-indent-level 2) 4 2))
        (setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
             (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
             (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-ivndent-offset 2) 4 2)))

  (setq indent-tabs-mode nil))

;;配置 js2-refactor
(add-hook 'js2-mode-hook #'js2-refactor-mode)

;;配置flycheck
;;(global-flycheck-mode t)
(add-hook 'js2-mode-hook 'flycheck-mode)

;;配置yasnippet
(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

;;配置auto-yasnippet
(global-set-key (kbd "H-w") #'aya-create)
(global-set-key (kbd "H-y") #'aya-expand)


;;启动evil
(evil-mode -1)
;;
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map [escape] 'evil-normal-state)

;;leader-key 
(global-evil-leader-mode )
(evil-leader/set-key
  "ff" 'find-file
  "fr" 'recentf-open-files
  "bb" 'switch-to-buffer
  "bk" 'kill-buffer
  "0" 'select-window-0
  "1" 'select-window-1
  "2" 'select-window-2
  "3" 'select-window-3
  "w/" 'split-window-right 
  "w-" 'split-window-below
  ":"    'counsel-M-x
  "wm" 'delete-other-windows
  "qq"  'save-buffers-kill-terminal
  )   




;;配置window-numbering
(window-numbering-mode 1)

;;配置powerline
;;(require 'powerline)
;;(powerline-default-theme)


;;配置evil-surround
(require 'evil-surround)
(global-evil-surround-mode)

;;配置evil-nerd-commenter
(evilnc-default-hotkeys)
(define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines) 

;;配置powerline-evil
(require 'powerline-evil)

(dolist (mode '(ag-mode
		;;其他模式
		occur-mode
		))
  (add-to-list 'evil-emacs-state-modes mode))

(add-hook 'occur-mode-hook
	  (lambda()
	    (evil-add-hjkl-bindings occur-mode-map 'emacs
	      (kbd "/") 'evil-search-forward
	      (kbd "n") 'evil-search-next
	      (kbd "N") 'evil-search-previous
	      (kbd "C-d" 'evil-scroll-down
		   (kbd "C-u") 'evil-scroll-up)
	      )))
;;配置which-key
(which-key-mode 1)
(provide 'init-packages)
(setq which-key-side-window-location 'right) 
