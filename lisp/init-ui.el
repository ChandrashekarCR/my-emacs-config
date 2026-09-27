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

;; Doom-modeline — a modern, sleek modeline.  Require it before invoking its
;; minor mode; this also leaves a usable built-in modeline if it is unavailable.
(when (require 'doom-modeline nil t)
  (setq doom-modeline-icon nil
        doom-modeline-height 1
        doom-modeline-bar-width 4
        doom-modeline-buffer-file-name-style 'truncate-with-directory
        doom-modeline-minor-modes t
        doom-modeline-time t)
  (doom-modeline-mode 1))

;; Add our custom CPU/MEM monitor to the right side of the doom-modeline.
;; This appends it *after* everything else doom-modeline sets.
(when (featurep 'doom-modeline)
  (setq-default mode-line-format
                (append
                 (butlast (default-value 'mode-line-format)) ; everything except the last element
                 '((:eval (my/mode-line-monitor)) " ")      ; our CPU/MEM
                 (last (default-value 'mode-line-format))))) ; the last element (usually "")

(provide 'init-ui)
;;; init-ui.el ends here
