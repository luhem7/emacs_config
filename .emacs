(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)
 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(line-number-mode nil)
 '(package-selected-packages
   (quote
    (magit linum-relative monokai-theme evil-surround evil better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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
 
;; Changes some defaults starting options for emacs, one of which I like
;; is to hide the toolbar on startup
(auto-install-packages 'better-defaults)
(require 'better-defaults)
 
; Evil-mode for vim bindings
(auto-install-packages 'evil)
(require 'evil)
(evil-mode t)
 
; Like tpope's surround plugin for vim
(auto-install-packages 'evil-surround)
(require 'evil-surround)
(global-evil-surround-mode 1)
 
; Color theme
(auto-install-packages 'monokai-theme)
(load-theme 'monokai t)
 
; Set relative line numbers
(auto-install-packages 'linum-relative)
(require 'linum-relative)
(linum-relative-on)
(setq linum-relative-current-symbol "")

;; Always follow symlinks which point to version controlled files.
;; Apparently emacs can also the symlink controlled file at the location of the
;; symlink itself, but doing this will bypass version control systems
;; http://stackoverflow.com/questions/15390178/emacs-and-symbolic-links
(setq vc-follow-symlinks t)

;; magit extendtion for running git commands through emacs
(auto-install-packages 'magit)
(global-set-key (kbd "C-x g") 'magit-status)
