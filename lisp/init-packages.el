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

;; Refresh package contents only when explicitly requested. A transient archive
;; or mirror failure should not make an otherwise usable editor unstartable.
(defvar my/package-refresh-on-startup nil)
(when (and my/package-refresh-on-startup
           (not package-archive-contents))
  (package-refresh-contents))

;; Install 'gnu-elpa-keyring-update' first when it is available locally. Package
;; installation is intentionally best-effort during startup.
(unless (package-installed-p 'gnu-elpa-keyring-update)
  (condition-case err
      (package-install 'gnu-elpa-keyring-update)
    (error (message "Skipping keyring update: %s" (error-message-string err)))))

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
    doom-modeline
    yasnippet))

;; Install any packages that aren't already installed, without making startup
;; depend on a live package archive.
(dolist (pkg my-packages)
  (unless (package-installed-p pkg)
    (condition-case err
        (package-install pkg)
      (error (message "Skipping package %s: %s" pkg (error-message-string err))))))

;; Load use-package (it's not built-in for Emacs 27).
(unless (package-installed-p 'use-package)
  (condition-case err
      (package-install 'use-package)
    (error (message "Skipping use-package installation: %s" (error-message-string err)))))
(require 'use-package)

;; Re-enable signature checking for future sessions.
;; The keyring update package will have been loaded, so this should now work.
(setq package-check-signature t)

(provide 'init-packages)
;;; init-packages.el ends here
