(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

; A function to help automatically install packages if they are not installed
(defun auto-install-packages(&rest packages)
  "Automatically install a package if it is not installed"
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
                nil
       (package-install package)
       ))
     packages))

;; Install all the packages we need at the top here
(auto-install-packages
 'better-defaults
 'evil
 'evil-surround
 'monokai-theme
 'linum-relative
 'magit
 'helm
 )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(line-number-mode nil)
 '(package-selected-packages
   (quote
    (helm magit linum-relative monokai-theme evil-surround evil better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 111 :width normal :foundry "PfEd" :family "Inconsolata")))))

;; Always follow symlinks which point to version controlled files.
;; Apparently emacs can also the symlink controlled file at the location of the
;; symlink itself, but doing this will bypass version control systems
;; http://stackoverflow.com/questions/15390178/emacs-and-symbolic-links
(setq vc-follow-symlinks t)

;; Always indent on newline
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Changes some defaults starting options for emacs, one of which I like
;; is to hide the toolbar on startup
(require 'better-defaults)
 
; Evil-mode for vim bindings
(require 'evil)
(evil-mode t)
 
; Like tpope's surround plugin for vim
(require 'evil-surround)
(global-evil-surround-mode 1)
 
; Color theme
(require 'monokai-theme)
(load-theme 'monokai t)
 
; Set relative line numbers
(require 'linum-relative)
(linum-mode)
(linum-relative-on)
(setq linum-relative-current-symbol "")

;; magit extendtion for running git commands through emacs
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; Helm related settings
;; Great tutorial about helm: https://tuhdo.github.io/helm-intro.html
(require 'helm)
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))
(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line        t)
(helm-autoresize-mode t)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x M-f") 'helm-occur)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
(helm-mode 1)
