;;; init-packages.el --- Package Management -*- lexical-binding: t; -*-
;;; Commentary:
;; Sets up MELPA and installs required packages.

;;; Code:

(require 'package)

;; Add MELPA and GNU ELPA to the package archives.
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

;; Initialize the package system.
(package-initialize)

;; ============================================================================
;; IMPORTANT: Disable signature checking for this session to avoid GPG errors.
;; We will manually install the keyring update to fix this permanently.
;; ============================================================================
(setq package-check-signature nil)

;; Refresh package contents (only if needed).
(unless package-archive-contents
  (package-refresh-contents))

;; Install 'gnu-elpa-keyring-update' first. This package imports the new GPG
;; keys so future signature checks will work.
(unless (package-installed-p 'gnu-elpa-keyring-update)
  (package-install 'gnu-elpa-keyring-update))

;; Now, define the list of packages we want.
(defvar my-packages
  '(which-key
    ivy
    counsel
    swiper
    projectile
    magit
    company
    flycheck
    diredfl
    doom-modeline))

;; Install any packages that aren't already installed.
(dolist (pkg my-packages)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;; Load use-package (it's not built-in for Emacs 27).
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; Re-enable signature checking for future sessions.
;; The keyring update package will have been loaded, so this should now work.
(setq package-check-signature t)

(provide 'init-packages)
;;; init-packages.el ends here
