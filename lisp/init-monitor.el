;;; init-monitor.el --- Custom CPU/Memory monitor -*- lexical-binding: t; -*-
;;; Commentary:
;; Reads /proc/stat and /proc/meminfo to display live CPU and memory usage.

;;; Code:

(defvar my/monitor-timer nil)
(defvar my/cpu-sample nil)
(defvar my/cpu-percent 0.0)
(defvar my/mem-percent 0.0)

(defun my/usage-bars (percent)
  "Render PERCENT as a small eight-segment usage graph."
  (let ((filled (round (* 8 (/ (min 100.0 (max 0.0 percent)) 100.0)))))
    (concat (make-string filled ?█)
            (make-string (- 8 filled) ?·))))

(defun my/read-cpu-sample ()
  "Return total and busy CPU ticks from /proc/stat."
  (with-temp-buffer
    (insert-file-contents "/proc/stat")
    (goto-char (point-min))
    (when (re-search-forward
           "^cpu +\\([0-9]+\\) +\\([0-9]+\\) +\\([0-9]+\\) +\\([0-9]+\\)"
           nil t)
      (let ((user (string-to-number (match-string 1)))
            (nice (string-to-number (match-string 2)))
            (system (string-to-number (match-string 3)))
            (idle (string-to-number (match-string 4))))
        (cons (+ user nice system idle) (+ user nice system))))))

(defun my/read-memory-percent ()
  "Return used memory as a percentage from /proc/meminfo."
  (with-temp-buffer
    (insert-file-contents "/proc/meminfo")
    (goto-char (point-min))
    (when (re-search-forward "^MemTotal:[ \t]+\\([0-9]+\\)" nil t)
      (let ((total (string-to-number (match-string 1))))
        (goto-char (point-min))
        (when (re-search-forward "^MemAvailable:[ \t]+\\([0-9]+\\)" nil t)
          (* 100.0 (/ (float (- total (string-to-number (match-string 1))))
                      total)))))))

(defun my/update-system-monitor ()
  "Update CPU and memory samples and refresh the mode line."
  (condition-case nil
      (let ((sample (my/read-cpu-sample))
            (memory (my/read-memory-percent)))
        (when (and sample my/cpu-sample)
          (let ((total-delta (- (car sample) (car my/cpu-sample)))
                (busy-delta (- (cdr sample) (cdr my/cpu-sample))))
            (when (> total-delta 0)
              (setq my/cpu-percent
                    (* 100.0 (/ (float busy-delta) total-delta))))))
        (when memory
          (setq my/mem-percent memory))
        (setq my/cpu-sample sample)
        (force-mode-line-update t))
    (error nil)))

(defun my/cpu-usage ()
  "Return a compact CPU usage graph."
  (format "CPU %s %4.1f%%" (my/usage-bars my/cpu-percent) my/cpu-percent))

(defun my/mem-usage ()
  "Return a compact memory usage graph."
  (format "RAM %s %4.1f%%" (my/usage-bars my/mem-percent) my/mem-percent))

(defun my/mode-line-monitor ()
  "Return a propertized string for the mode-line with CPU and RAM stats."
  (concat
   (propertize (my/cpu-usage) 'face '(:foreground "#8ec07c" :weight bold))
   " "
   (propertize (my/mem-usage) 'face '(:foreground "#fabd2f" :weight bold))))

(my/update-system-monitor)
(setq my/monitor-timer (run-with-timer 1 2 #'my/update-system-monitor))

(provide 'init-monitor)
;;; init-monitor.el ends here
