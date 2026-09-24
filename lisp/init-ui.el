;;; init-ui.el --- Look and Feel -*- lexical-binding: t; -*-
;;; Commentary:
;; Doom-modeline + wombat theme + integrated CPU/MEM monitor.

;;; Code:

;; Load a dark theme.
(load-theme 'wombat t)

;; Enable time display.
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date nil)

;; Doom-modeline — a modern, sleek modeline.
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  ;; IMPORTANT for terminal: disable icons (no Nerd Font needed).
  (setq doom-modeline-icon nil)
  (setq doom-modeline-height 1)
  (setq doom-modeline-bar-width 4)
  (setq doom-modeline-buffer-file-name-style 'truncate-with-directory)
  ;; Show minor modes so you can see ivy, projectile, flycheck, etc.
  (setq doom-modeline-minor-modes t)
  ;; Show the current time.
  (setq doom-modeline-time t))

;; Add our custom CPU/MEM monitor to the right side of the doom-modeline.
;; This appends it *after* everything else doom-modeline sets.
(with-eval-after-load 'doom-modeline
  (setq-default mode-line-format
                (append
                 (butlast (default-value 'mode-line-format)) ; everything except the last element
                 '((:eval (my/mode-line-monitor)) " ")      ; our CPU/MEM
                 (last (default-value 'mode-line-format))))) ; the last element (usually "")

(provide 'init-ui)
;;; init-ui.el ends here
