;;; init-productivity.el --- Org, sessions, and keyboard-first workflows -*- lexical-binding: t; -*-

;;; Code:

(require 'org)
(require 'org-capture)
(require 'org-agenda)
(require 'tab-bar)
(require 'desktop)

(defconst my/org-directory (expand-file-name "org/" user-emacs-directory))
(dolist (directory '("" "notes" "journal"))
  (make-directory (expand-file-name directory my/org-directory) t))

(setq org-directory my/org-directory
      org-default-notes-file (expand-file-name "inbox.org" org-directory)
      org-agenda-files (list org-default-notes-file
                             (expand-file-name "journal" org-directory))
      org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)"))
      org-log-done 'time
      org-return-follows-link t
      org-startup-indented t
      org-hide-emphasis-markers t
      org-agenda-window-setup 'current-window
      org-capture-templates
      `(("i" "Inbox task" entry
         (file ,(expand-file-name "inbox.org" org-directory))
         "* TODO %?\n  %U\n")
        ("n" "Note" entry
         (file+headline ,(expand-file-name "notes.org" org-directory) "Notes")
         "* %?\n  %U\n")
        ("j" "Journal" entry
         (file+olp+datetree ,(expand-file-name "journal/journal.org" org-directory))
         "* %?\n  %U\n")))

(dolist (file '("inbox.org" "notes.org" "journal/journal.org"))
  (let ((path (expand-file-name file org-directory)))
    (unless (file-exists-p path)
      (with-temp-file path
        (insert (if (string= file "notes.org") "#+title: Notes\n\n* Notes\n" ""))))))

;; Desktop saves buffers and windows; tab-bar keeps named workspaces in one
;; Emacs process, which covers the everyday tmux-session workflow.
(setq desktop-path (list user-emacs-directory)
      desktop-auto-save-timeout 300
      desktop-save t)
(desktop-save-mode 1)

(defun my/tab-bar-switch-to-tab (tab-number)
  "Switch to TAB-NUMBER, or show a message when it does not exist."
  (interactive "nTab number: ")
  (if (<= tab-number (length (tab-bar-tabs)))
      (tab-bar-select-tab tab-number)
    (user-error "No tab %d exists" tab-number)))

(global-set-key (kbd "C-c w n") #'tab-bar-new-tab)
(global-set-key (kbd "C-c w k") #'tab-bar-close-tab)
(global-set-key (kbd "C-c w r") #'tab-bar-rename-tab)
(global-set-key (kbd "C-c w l") #'tab-bar-switch-to-next-tab)
(global-set-key (kbd "C-c w h") #'tab-bar-switch-to-prev-tab)
(global-set-key (kbd "C-c w 1") (lambda () (interactive) (my/tab-bar-switch-to-tab 1)))
(global-set-key (kbd "C-c w 2") (lambda () (interactive) (my/tab-bar-switch-to-tab 2)))
(global-set-key (kbd "C-c w 3") (lambda () (interactive) (my/tab-bar-switch-to-tab 3)))

(global-set-key (kbd "C-c o c") #'org-capture)
(global-set-key (kbd "C-c o a") #'org-agenda)
(global-set-key (kbd "C-c o f") #'org-open-at-point)
(global-set-key (kbd "C-c o t") #'org-todo)

(provide 'init-productivity)
;;; init-productivity.el ends here