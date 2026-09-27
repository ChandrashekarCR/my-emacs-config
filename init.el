;;; init.el --- My Emacs Configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; A terminal-optimized, productivity-focused Emacs setup.

;;; Code:

;; 1. Set up the load path for our custom modules.  Use the location of this
;; file when available so startup also works with a custom `-q`/`-l` path or a
;; symlinked Emacs home.
(defconst my/config-directory
  (file-name-directory
   (expand-file-name (or load-file-name user-init-file
                           (expand-file-name "init.el" user-emacs-directory))))
  "Directory containing this Emacs configuration.")
(defconst my/config-lisp-directory
  (expand-file-name "lisp" my/config-directory)
  "Directory containing this configuration's custom modules.")
(unless (file-directory-p my/config-lisp-directory)
  (error "Emacs config module directory does not exist: %s"
         my/config-lisp-directory))
(add-to-list 'load-path my/config-lisp-directory)

;; 2. Basic UI/UX Settings (These are safe and don't require packages)
(setq inhibit-startup-screen t) ; No splash screen
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq warning-minimum-level :error)

(global-display-line-numbers-mode t) ; Line numbers on the left
(show-paren-mode t)                  ; Highlight matching parentheses

(setq make-backup-files nil)         ; No backup files
(setq auto-save-default nil)         ; No auto-save files
(setq create-lockfiles nil)          ; No lock files
(add-hook 'before-save-hook 'delete-trailing-whitespace) ; Clean whitespace
(setq use-short-answers t)           ; y/n instead of yes/no
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

;; 3. Load our custom modules
(require 'init-packages) ; Handles package installation
(require 'init-editing)  ; CUA bindings, completion, etc.
(require 'init-navigation) ; Dired, Projectile, etc.
(require 'init-monitor)  ; System monitor
(require 'init-ui)       ; Theme + mode-line (user monitor functions)

;; 4. Essential global keybindings
;; Window management (tmux-like)
(global-set-key (kbd "M-o")   'other-window)         ; still works
(global-set-key (kbd "C-c 1") 'delete-other-windows) ; was M-1
(global-set-key (kbd "C-c 2") 'split-window-below)   ; was M-2
(global-set-key (kbd "C-c 3") 'split-window-right)   ; was M-3
(global-set-key (kbd "C-c 0") 'delete-window)        ; close current window
(winner-mode 1)
(windmove-default-keybindings 'meta)

;; Keyboard-first workspace tabs.
(tab-bar-mode 1)
(setq tab-bar-show 1
      tab-bar-close-button-show nil
      tab-bar-new-tab-choice "*scratch*"
      tab-bar-tab-hints t)
(global-set-key (kbd "C-c t n") #'tab-bar-new-tab)
(global-set-key (kbd "C-c t c") #'tab-bar-close-tab)
(global-set-key (kbd "C-c t l") #'tab-bar-switch-to-next-tab)
(global-set-key (kbd "C-c t h") #'tab-bar-switch-to-prev-tab)
(global-set-key (kbd "C-c t r") #'tab-bar-rename-tab)
(global-set-key (kbd "C-c t 1") (lambda () (interactive) (tab-bar-select-tab 1)))
(global-set-key (kbd "C-c t 2") (lambda () (interactive) (tab-bar-select-tab 2)))
(global-set-key (kbd "C-c t 3") (lambda () (interactive) (tab-bar-select-tab 3)))
(with-eval-after-load 'term
  (define-key term-raw-map (kbd "M-o") 'other-window)) ; Swtich to other window

;; Org-mode global keys
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company counsel diredfl flycheck gnu-elpa-keyring-update magit
	     projectile which-key)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'erase-buffer 'disabled nil)
