;; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(tool-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)

;; 显示行号
(global-linum-mode -1)

;; 关闭启动帮助画面
(setq inhibit-splash-screen -1)

;;设置光标样式
(setq-default cursor-type 'bar)

;;默认全屏
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;;设置默认字体
;;(set-default-font "微软雅黑-15")

;;高亮当前行
(global-hl-line-mode t)


(provide 'init-ui)
