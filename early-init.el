;; -*- lexical-binding: t; -*-
;; (load "~/.emacs.d/modules/crafted-early-init-config")

;; `https://github.com/nilcons/emacs-use-package-fast'
;; `https://github.com/casouri/lunarymacs/blob/master/early-init.el'
(add-hook 'emacs-startup-hook
          (let ((old-list file-name-handler-alist)
                ;; If x10, half of cpu time is spent on gc when
                ;; scrolling.
                ;; (threshold (* 100 gc-cons-threshold))
                ;; Let’s try a smaller number, more frequent gc means
                ;; shorter gc pause.
                (threshold (* 4 gc-cons-threshold))
                (percentage gc-cons-percentage))
            (lambda ()
              (message "Emacs ready in %s with %d garbage collections."
                       (format "%.2f seconds"
                               (float-time
                                (time-subtract after-init-time before-init-time)))
                       gcs-done)
              (setq file-name-handler-alist old-list
                    gc-cons-threshold threshold
                    gc-cons-percentage percentage)
              (garbage-collect)))
          t)

(setopt package-enable-at-startup nil)
(setq file-name-handler-alist nil
      message-log-max 16384
      gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      auto-window-vscroll nil)

(push '(vertical-scroll-bars . nil) default-frame-alist)
(push '(left . 300) default-frame-alist)
(push '(top . 100) default-frame-alist)

(setopt package-archives '(("gnu"    . "https://mirrors.lzu.edu.cn/elpa/gnu/")
                         ("nongnu" . "https://mirrors.lzu.edu.cn/elpa/nongnu/")
                         ("melpa"  . "https://mirrors.lzu.edu.cn/elpa/melpa/")))

(setopt package-archive-priorities
        '(("gnu"    . 99)
          ("nongnu" . 80)
          ("melpa"  . 70)
          ))
