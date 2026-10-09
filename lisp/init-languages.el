;;; init-languages.el --- Language-specific configurations -*- lexical-binding: t; -*-
;;; Commentary:
;; Rust, Python, etc.

;;; Code:

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
