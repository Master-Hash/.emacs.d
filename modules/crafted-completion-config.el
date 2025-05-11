;;; crafted-completion-config.el --- Crafted Completion Configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2023
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;;; Commentary:

;; Setup completion packages. Completion in this sense is more like
;; narrowing, allowing the user to find matches based on minimal
;; inputs and "complete" the commands, variables, etc from the
;; narrowed list of possible choices.

;;; Code:

;;; Vertico
;; (when (require 'vertico nil :noerror)
;;   (require 'vertico-directory)
;;   ;; Cycle back to top/bottom result when the edge is reached
;;   (customize-set-variable 'vertico-cycle t)

;;   ;; Start Vertico
;;   (vertico-mode 1)

;;   ;; Turn off the built-in fido-vertical-mode and icomplete-vertical-mode, if
;;   ;; they have been turned on by crafted-defaults-config, because they interfere
;;   ;; with this module.
;;   (with-eval-after-load 'crafted-defaults-config
;;     (fido-mode -1)
;;     (fido-vertical-mode -1)
;;     (icomplete-mode -1)
;;     (icomplete-vertical-mode -1)))

(use-package vertico
  :ensure
  ;; :defer
  ;; :commands (execute-extended-command)
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode +1)
  )


;;; Marginalia
;; (when (require 'marginalia nil :noerror)
;;   ;; Configure Marginalia
;;   (customize-set-variable 'marginalia-annotators
;;                           '(marginalia-annotators-heavy
;;                             marginalia-annotators-light
;;                             nil))
;;   (marginalia-mode 1))

(use-package marginalia
  :ensure
  ;; :defer 0.02
  ;; :after (vertico)
  :init
  (marginalia-mode +1)
  )


;;; Consult
;; Since Consult doesn't need to be required, we assume the user wants these
;; setting if it is installed (regardless of the installation method).
;; (when (locate-library "consult")
;;   ;; Set some consult bindings
;;   (keymap-global-set "C-s" 'consult-line)
;;   (keymap-set minibuffer-local-map "C-r" 'consult-history)

;;   (setq completion-in-region-function #'consult-completion-in-region))

;; (defun hash--consult-line-with-region ()
;;   (interactive)

;;     )

(use-package avy
  :ensure
  :bind (("C-s" . avy-goto-char-timer)))

(use-package consult
  :ensure
  ;; :defer
  ;; :commands (isearch-forward)
  ;; :custom (consult-line-start-from-top t)
  :bind (
         ("C-r" . consult-line)
         ("M-g g" . consult-goto-line)
         ("C-x b" . consult-buffer)
         ("C-x p b" . consult-project-buffer)
         ("C-c r g" . consult-ripgrep)
         ("C-c f d" . consult-fd)
         (:map minibuffer-local-map
               ("C-r" . consult-history)))
  :init
  (setopt xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  (consult-customize
   consult-ripgrep consult-theme consult-ripgrep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.2 any)
   consult-line
   ;; `https://www.reddit.com/r/emacs/comments/17t1yjx/consultline_with_cw/'
   ;; :initial (thing-at-point 'symbol)
   :initial (if (use-region-p)
                (buffer-substring (region-beginning) (region-end))
              ;; (thing-at-point 'symbol)
              ""
              )
   ;; :add-history (seq-some #'thing-at-point '(region symbol))
   :preview-key '(:debounce 0.2 any)))


;;; Orderless
;; (when (require 'orderless nil :noerror)
;;   ;; Set up Orderless for better fuzzy matching
;;   (customize-set-variable 'completion-styles '(orderless basic))
;;   (customize-set-variable 'completion-category-overrides
;;                           '((file (styles . (partial-completion))))))

(use-package orderless
  :ensure
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))


;;; Embark
;; (when (require 'embark nil :noerror)

;;   (keymap-global-set "<remap> <describe-bindings>" #'embark-bindings)
;;   (keymap-global-set "C-." 'embark-act)

;;   ;; Use Embark to show bindings in a key prefix with `C-h`
;;   (setq prefix-help-command #'embark-prefix-help-command)

;;   (when (require 'embark-consult nil :noerror)
;;     (with-eval-after-load 'embark-consult
;;       (add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode))))

(use-package embark
  :ensure
  :defer t
  :bind (("C-h b" . embark-bindings)
         ("C-h /" . embark-act))
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))


;;; Corfu
;; (when (require 'corfu nil :noerror)

;;   (unless (display-graphic-p)
;;     (when (require 'corfu-terminal nil :noerror)
;;       (corfu-terminal-mode +1)))

;;   ;; Setup corfu for popup like completion
;;   (customize-set-variable 'corfu-cycle t)        ; Allows cycling through candidates
;;   (customize-set-variable 'corfu-auto t)         ; Enable auto completion
;;   (customize-set-variable 'corfu-auto-prefix 2)  ; Complete with less prefix keys

;;   (global-corfu-mode 1)
;;   (when (require 'corfu-popupinfo nil :noerror)

;;     (corfu-popupinfo-mode 1)
;;     (eldoc-add-command #'corfu-insert)
;;     (keymap-set corfu-map "M-p" #'corfu-popupinfo-scroll-down)
;;     (keymap-set corfu-map "M-n" #'corfu-popupinfo-scroll-up)
;;     (keymap-set corfu-map "M-d" #'corfu-popupinfo-toggle)))

(use-package corfu
  :ensure
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-prefix 2)
  :bind (:map corfu-map
              ("M-p" . corfu-popupinfo-scroll-down)
              ("M-n" . corfu-popupinfo-scroll-up)
              ("M-d" . corfu-popupinfo-toggle))
  :init
  (global-corfu-mode 1)
  :config
  ;; delete when Emacs 31
  (unless (display-graphic-p)
    (when (require 'corfu-terminal nil :noerror)
      (corfu-terminal-mode +1)))
  (when (require 'corfu-popupinfo nil :noerror)
    (corfu-popupinfo-mode +1)
    (eldoc-add-command #'corfu-insert)
    ;; (keymap-set corfu-map "M-p" #'corfu-popupinfo-scroll-down)
    ;; (keymap-set corfu-map "M-n" #'corfu-popupinfo-scroll-up)
    ;; (keymap-set corfu-map "M-d" #'corfu-popupinfo-toggle)
    )
  )


;;; Cape

;; (when (require 'cape nil :noerror)
;;   ;; Setup Cape for better completion-at-point support and more

;;   ;; Add useful defaults completion sources from cape
;;   (add-to-list 'completion-at-point-functions #'cape-file)
;;   (add-to-list 'completion-at-point-functions #'cape-dabbrev)

;;   ;; Silence the pcomplete capf, no errors or messages!
;;   ;; Important for corfu
;;   (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)

;;   ;; Ensure that pcomplete does not write to the buffer
;;   ;; and behaves as a pure `completion-at-point-function'.
;;   (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify)

;;   ;; No auto-completion or completion-on-quit in eshell
;;   (defun crafted-completion-corfu-eshell ()
;;     "Special settings for when using corfu with eshell."
;;     (setq-local corfu-quit-at-boundary t
;;                 corfu-quit-no-match t
;;                 corfu-auto nil)
;;     (corfu-mode))
;;   (add-hook 'eshell-mode-hook #'crafted-completion-corfu-eshell))

(use-package cape
  :ensure
  :defer t
  :bind ("C-c p" . cape-prefix-map)
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  :config
  ;; No auto-completion or completion-on-quit in eshell
  (defun crafted-completion-corfu-eshell ()
    "Special settings for when using corfu with eshell."
    (setq-local corfu-quit-at-boundary t
                corfu-quit-no-match t
                corfu-auto nil)
    (corfu-mode 1))
  (add-hook 'eshell-mode-hook #'crafted-completion-corfu-eshell)
  )

(provide 'crafted-completion-config)
;;; crafted-completion.el ends here
