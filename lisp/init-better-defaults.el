;; 关闭警告音
(setq ring-bell-function 'ignore)

;;缩写补全
(abbrev-mode 1)
(define-abbrev-table 'global-abbrev-table '(
                                            ("8pj" "pjpgy")
                                            ("8Pj" "PjPgy")
					    ("8em" "emacs-lisp")
					    ))

;;关闭自动备份
(setq make-backup-files nil)

(setq auto-save-default nil)

;;利用C-x C-r 打开最近文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

;; 括号匹配
(add-hook 'emacs-lisp-mode-hook' show-paren-mode)


;;显示内容所属括号
(defadvice show-paren-function (around  fix-show-paren-function activate)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(")  ad-do-it)
	(t (save-excursion
	     (ignore-errors (backward-up-list))  ad-do-it)))
)
;;选中一段文字之后输入一个字符会替换掉你选中部分的文字
(delete-selection-mode 1)

;;自动加载外部改动
(global-auto-composition-mode t)

;; 缩进
(defun indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indent selected region."))
      (progn
        (indent-buffer)
        (message "Indent buffer.")))))

(setq hippie-expand-try-function-list '(try-expand-debbrev
                                        try-expand-debbrev-all-buffers
                                        try-expand-debbrev-from-kill
                                        try-complete-file-name-partially
                                        try-complete-file-name
                                        try-expand-all-abbrevs
                                        try-expand-list
                                        try-expand-line
                                        try-complete-lisp-symbol-partially
                                        try-complete-lisp-symbol))
;;配置Dired Mode
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
;;只生成一个buffer
(put 'dired-find-alternate-file 'disabled nil)
(require 'dired)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(require 'dired-x)
;;另一个分屏自动设置成拷贝地址的目标
(setq dired-dwin-target 1)

;; 隐藏DOC编码的换行符
(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (unless buffer-display-table
    (setq buffer-display-table (make-display-table)))
  (aset buffer-display-table ?\^M []))
;;删除DOC编码的换行符
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;;(setq split-width-threshold 0)
;;Occur Mode
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties
	     (region-beginning)
	     (region-end))
	  (let ((sym (thing-at-point 'symbol)))
	    (when (stringp sym)
	      (regexp-quote sym))))
	regexp-history)
  (call-interactively 'occur))
(global-set-key (kbd "M-s o") 'occur-dwim)


;;imenu
(defun js2-imenu-make-index ()
      (interactive)
      (save-excursion
        ;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
        (imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                                   ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
                                   ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))
(add-hook 'js2-mode-hook
              (lambda ()
                (setq imenu-create-index-function 'js2-imenu-make-index)))

;;C-w 向后删除一个字符
;;(global-set-key (kbd "C-w") 'backward-kill-word)

(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

(sp-local-pair 'emacs-lisp-mode "`" nil :actions nil)
 (provide 'init-better-defaults)
