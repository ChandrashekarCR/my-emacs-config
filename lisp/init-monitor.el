;;; init-monitor.el --- Custom CPU/Memory monitor -*- lexical-binding: t; -*-
;;; Commentary:
;; Reads /proc/loadavg and /proc/meminfo to display CPU and memory usage
;; in the mode-line, No external packages required.

;;; Code:

(defvar my/cpu-count nil "Cached number of CPU cores.")

(defun my/get-cpu-count ()
  "Return the number of CPU cores, cached after first call."
  (or my/cpu-count
      (with-temp-buffer
        (insert-file-contents "/proc/stat")
        (goto-char (point-min))
        (let ((count 0))
          (while (re-search-forward "^cpu[0-9]+" nil t)
            (setq count (1+ count)))
          (setq my/cpu-count (max 1 count))))))

(defun my/cpu-usage ()
  "Return CPU usage as a percentage string."
  (condition-case nil
      (with-temp-buffer
        (insert-file-contents "/proc/loadavg")
        (let* ((load (string-to-number
                      (car (split-string (buffer-string) " "))))
               (cores (my/get-cpu-count))
               (pct (* 100.0 (/ load cores))))
          (format "CPU %4.1f%%" pct)))
    (error "CPU --.-%")))

(defun my/mem-usage ()
  "Return memory usage as a percentage string."
  (condition-case nil
      (with-temp-buffer
        (insert-file-contents "/proc/meminfo")
        (goto-char (point-min))
        (let ((total 0) (avail 0))
          (when (re-search-forward "^MemTotal:[ \t]+\\([0-9]+\\)" nil t)
            (setq total (string-to-number (match-string 1))))
          (goto-char (point-min))
          (when (re-search-forward "^MemAvailable:[ \t]+\\([0-9]+\\)" nil t)
            (setq avail (string-to-number (match-string 1))))
          (if (> total 0)
              (format "MEM %4.1f%%" (/ (* 100.0 (- total avail)) total))
            "MEM --.-%")))
    (error "MEM --.-%")))

(defun my/mode-line-monitor ()
  "Return a propertized string for the mode-line with CPU and MEM stats."
  (concat
   (propertize (my/cpu-usage)
               'face '(:foreground "#8ec07c" :weight bold))
   " "
   (propertize (my/mem-usage)
               'face '(:foreground "#fabd2f" :weight bold))))

(provide 'init-monitor)
;;; init-monitor.el ends here
