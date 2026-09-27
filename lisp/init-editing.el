;;; init-editing.el --- Core Editing Setup -*- lexical-binding: t; -*-
;;; Commentary:
;; CUA bindings, auto-completion, etc.

;;; Code:

;; Enable global company-mode for auto-completion.
(setq company-idle-delay 0.2
      company-minimum-prefix-length 1
      company-selection-wrap-around t
      company-tooltip-align-annotations t
      company-require-match nil)
(global-company-mode 1)
(with-eval-after-load 'company
  (define-key company-active-map (kbd "TAB") #'company-complete-selection)
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;; Enable global flycheck for syntax checking.
(global-flycheck-mode 1)

;; Which-key: Shows available keybindings after a prefix.
(which-key-mode 1)

;; Ivy for completion.
(ivy-mode 1)
(setq ivy-use-virtual-buffers t
      enable-recursive-minibuffers t)

;; Counsel provides enhanced versions of standard Emacs commands.
;; Swiper provides a better search (C-s).
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "C-c s") 'counsel-rg) ; Search project with ripgrep

(provide 'init-editing)
;;; init-editing.el ends here
