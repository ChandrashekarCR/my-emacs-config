;;; init-navigation.el --- Navigation and File Management -*- lexical-binding: t; -*-
;;; Commentary:
;; Dired, Projectile, and Magit setup.

;;; Code:

;; Enable Projectile for project management.
(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Magit for Git.
(global-set-key (kbd "C-c g") 'magit-status)

;; Dired improvements
(require 'dired-x)
(setq dired-listing-switches "-alh --group-directories-first") ; Human-readable sizes, dirs first
(setq dired-dwim-target t) ; Guess target directory for copy/rename
;; Use diredfl for colorful dired listings (if installed)
(when (require 'diredfl nil t)
  (diredfl-global-mode 1))

;; Navigate with dired using arrow keys or n/p
(define-key dired-mode-map (kbd "n") 'dired-next-line)
(define-key dired-mode-map (kbd "p") 'dired-previous-line)

(provide 'init-navigation)
;;; init-navigation.el ends here
