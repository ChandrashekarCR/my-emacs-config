;;; init-editing.el --- Core Editing Setup -*- lexical-binding: t; -*-
;;; Commentary:
;; CUA bindings, auto-completion, etc.

;;; Code:

;; Enable global company-mode for auto-completion.
(global-company-mode 1)
(setq company-idle-delay 0.2
      company-minimum-prefix-length 1)

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
