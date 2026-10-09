;;; init-languages.el --- Language-specific configurations -*- lexical-binding: t; -*-
;;; Commentary:
;; Rust, Python, etc.

;;; Code:

;; ─────────────────────────────────────────────────────────────────────────────
;; Rust
;; ─────────────────────────────────────────────────────────────────────────────
(use-package rustic
  :ensure t
  :mode ("\\.rs\\'" . rustic-mode)
  :config
  (setq rustic-lsp-server 'rust-analyzer) ; Explicitly use rust-analyzer
  (setq rustic-format-on-save t)          ; Format buffer on save
  (setq lsp-rust-analyzer-cargo-watch-command "clippy") ; Use clippy for diagnostics
  (setq lsp-rust-analyzer-proc-macro-enable t)
  :hook
  (rustic-mode . lsp-deferred)) ; Start LSP when a Rust file is opened

(use-package lsp-mode
  :ensure t
  :hook
  (lsp-mode . lsp-enable-which-key-integration)
  :commands lsp
  :config
  (setq lsp-idle-delay 0.5
        lsp-enable-snippet t
        lsp-completion-provider :capf) ; Use company-capf for completion
  (setq lsp-rust-server 'rust-analyzer))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-hover t))

;; Ensure company can use LSP completions
(add-to-list 'company-backends 'company-capf)

(provide 'init-languages)
;;; init-languages.el ends here
