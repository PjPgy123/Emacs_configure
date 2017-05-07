;;文本高亮
(require 'org)
(setq org-src-fontify-natively t)

;; 设置默认 Org Agenda 文件目录
(setq org-agenda-files '("C:/Emacs25.1/PjPgy"))
;; 设置 org-agenda 打开快捷键



(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "C:/Emacs25.1/PjPgy/GTD.org" "工作安排")
         "* TODO [#B] %?\n  %i\n"
         :empty-lines 1)))


(provide 'init-org)
