;;文本高亮
(require 'org)
(setq org-src-fontify-natively t)

;; 设置默认 Org Agenda 文件目录
(setq org-agenda-files '("/home/pjpgy/文档/Emacs25.1"))
;; 设置 org-agenda 打开快捷键



(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "/home/pjpgy/文档/Emacs25.1/GTD.org" "工作安排")
         "* TODO [#B] %?\n  %i\n"
         :empty-lines 1)))


(provide 'init-org)
