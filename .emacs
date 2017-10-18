;; Emacs startup settings
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq fancy-splash-image "/Users/relja/.emacs.d/splash.png")

;; Set path
(setenv "PATH" (concat (getenv "PATH") ":/usr/bin"))
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))
(setq exec-path (append exec-path '("/usr/bin")))

;; Enable recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; Enable MELPA
(require 'package) ;; You might already have this line
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("8ed752276957903a270c797c4ab52931199806ccd9f0c3bb77f6f4b9e71b9272" default)))
 '(haskell-tags-on-save t)
 '(package-selected-packages
   (quote
	(all-the-icons monokai-theme helm-projectile helm-flycheck flycheck d-mode company-dcd idea-darkula-theme haskell-mode sublimity python-mode projectile neotree magit julia-mode helm git auto-complete evil company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Setup indentation
(defun my-setup-indent (n)
  (setq c-basic-offset n)
  (setq nim-indent-line n)
  (setq coffee-tab-width n) ; coffeescript
  (setq haskell-indentation-layout-offset n)
  (setq javascript-indent-level n) ; javascript-mode
  (setq js-indent-level n) ; js-mode
  (setq js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
  (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq css-indent-offset n)) ; css-mode

(my-setup-indent 4)

;; Setup smooth scrolling
(setq scroll-step            1
      scroll-conservatively  10000)

;; Setup autocomplete
(ac-config-default)

;; Setup evil
(require 'evil)
(evil-mode 1)

(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd ":") 'evil-repeat-find-char)
  (define-key evil-motion-state-map (kbd ";") 'evil-ex))

(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
(setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
(add-to-list 'exec-path my-cabal-path))


(add-hook 'haskell-mode-hook #'hindent-mode)

(global-linum-mode)
(setq linum-format "%4d \u2502 ")
(setq-default tab-width 4)
(setq ns-use-srgb-colorspace nil)

(require 'haskell-mode)
(add-hook 'haskell-mode 'hindent--before-save)

;; (add-to-list 'yas-snippet-dirs "/Users/relja/.emacs.d/yasnippet-snippets")

;;(require 'uncrustify-mode)
;;(add-hook 'd-mode-hook 'uncrustify-mode)
;;(add-hook 'c-mode-hook 'uncrustify-mode)
;;(add-hook 'c++-mode-hook 'uncrustify-mode)

;; Switch .h to c++
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(defun indent-or-expand (arg)
"Either indent according to mode, or expand the word preceding point."
(interactive "*P")
(if (and
	(or (bobp) (= ?w (char-syntax (char-before))))
	(or (eobp) (not (= ?w (char-syntax (char-after))))))
    (hippie-expand arg)
    (indent-according-to-mode)))

(define-key evil-insert-state-map (kbd "TAB") 'indent-or-expand)

(setq python-shell-interpreter "/usr/local/bin/python2")

(require 'yasnippet)
(yas-global-mode 1)

;; Setup nim-mode
(require 'nim-mode)
(setq nim-nimsuggest-path "/usr/local/bin/nimsuggest")
(setq nim-compile-command "nimble build")
	  
(add-hook 'nim-mode-hook 'nimsuggest-mode)

(add-hook 'nim-mode-hook 'company-mode)
(add-hook 'nimscript-mode-hook 'company-mode)

;; Add ansi coloring
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; coloring in the shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

;; Load theme
(load-theme 'monokai)

(toggle-frame-maximized)

;; Dlang mode
(add-hook 'd-mode-hook 'company-dcd-mode)
(setq company-dcd-server-executable "/usr/local/bin/dcd-server")

;; Enable flycheck
(flycheck-mode 1)

;; Enable projectile
(projectile-mode 1)

;; Setup neotree with evil
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "r") 'neotree-change-root)

;; neotree themes :)
(require 'all-the-icons)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; other stuff
(setq neotree-window-position 'right)

;; --------- Setup Keybinding --------- ;;

(defun open-init ()
  "Open Emacs file. Shortcut convenience."
  (interactive)
  (switch-to-buffer (find-file-noselect "/Users/relja/.emacs")))

;; Keybidning
(global-set-key (kbd "C-x C-i") 'open-init)
(define-key (current-global-map) (kbd "C-x n") 'neotree-toggle)

(provide 'emacs)
;;; .emacs ends here
