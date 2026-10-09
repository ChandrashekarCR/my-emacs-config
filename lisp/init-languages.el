;;; init-languages.el --- Language-specific configurations -*- lexical-binding: t; -*-
;;; Commentary:
;; Rust, Python, etc.

;;; Code:

;; Emacs 31 includes native tree-sitter Rust mode. Basic editing should work
;; without any package downloads; eglot adds semantic completion and diagnostics
;; from the rust-analyzer executable already installed on this machine.
(defconst my/rust-analyzer
  (or (executable-find "rust-analyzer")
      (let ((candidate (expand-file-name "~/.cargo/bin/rust-analyzer")))
        (when (file-executable-p candidate) candidate)))
  "Absolute path to the Rust language server, when installed.")

(when my/rust-analyzer
  (let ((rust-bin (file-name-directory my/rust-analyzer)))
    (add-to-list 'exec-path rust-bin)
    (setenv "PATH" (concat rust-bin path-separator (getenv "PATH")))))

(when (and (fboundp 'rust-ts-mode)
           (fboundp 'treesit-available-p)
           (treesit-available-p))
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))
  (when my/rust-analyzer
    (require 'eglot)
    (setq eglot-autoshutdown t)
    (add-to-list 'eglot-server-programs
                 `(rust-ts-mode . (,my/rust-analyzer))))
  (add-hook 'rust-ts-mode-hook
            (lambda ()
              (when (fboundp 'company-mode)
                (company-mode 1))
              (when (and my/rust-analyzer
                         (fboundp 'eglot-ensure))
                ;; Let project.el/Projectile finish discovering the Cargo root.
                (run-at-time 0 nil
                             (lambda (buffer)
                               (when (buffer-live-p buffer)
                                 (with-current-buffer buffer
                                   (eglot-ensure))))
                             (current-buffer)))
              (when (fboundp 'eglot)
                (local-set-key (kbd "C-c C-l") #'eglot)))))

;; ─────────────────────────────────────────────────────────────────────────────
;; Rust
;; ─────────────────────────────────────────────────────────────────────────────
(when (and (require 'rustic nil t)
           (require 'lsp-mode nil t))
  (use-package rustic
    :mode ("\\.rs\\'" . rustic-mode)
    :config
    (setq rustic-lsp-server 'rust-analyzer)
    (setq rustic-format-on-save t)
    (setq lsp-rust-analyzer-cargo-watch-command "clippy")
    (setq lsp-rust-analyzer-proc-macro-enable t)
    :hook
    (rustic-mode . lsp-deferred)))

(when (require 'lsp-mode nil t)
  (use-package lsp-mode
    :ensure nil
    :hook
    (lsp-mode . lsp-enable-which-key-integration)
    :commands lsp
    :config
    (setq lsp-idle-delay 0.5
          lsp-enable-snippet t
          lsp-completion-provider :capf)
    (setq lsp-rust-server 'rust-analyzer)))

(when (require 'lsp-ui nil t)
  (use-package lsp-ui
    :ensure nil
    :commands lsp-ui-mode
    :config
    (setq lsp-ui-doc-enable t
          lsp-ui-sideline-enable t
          lsp-ui-sideline-show-hover t)))

;; Ensure company can use LSP completions
(add-to-list 'company-backends 'company-capf)

(provide 'init-languages)
;;; init-languages.el ends here
