;; -*- lexical-binding: t; -*-
;;; dump.el ---

;; `https://archive.casouri.cc/note/2020/painless-transition-to-portable-dumper/'

(load "c:/Users/hash/AppData/Roaming/.emacs.d/modules/crafted-init-config")
;; (require 'crafted-defaults-config)
;; (require 'crafted-completion-config)

(require 'package)
;; load autoload files and populate load-path’s
(package-initialize)
(setq luna-dumped-load-path load-path
      luna-dumped t)
;; (package-initialize) ;; doens’t require each package, we need to load
;; those we want manually
(dolist (package '(
                   ;; Built-ins
                   autoinsert
                   autorevert
                   china-util
                   comint
                   cua-base completion-preview
                   delsel
                   diff-mode
                   display-line-numbers
                   easy-mmode
                   eldoc
                   elec-pair
                   electric
                   epa-hook
                   font-lock
                   help-mode
                   icons
                   menu-bar tool-bar
                   mouse
                   package-vc
                   paren
                   pixel-scroll
                   project
                   repeat
                   rfn-eshadow
                   savehist
                   so-long
                   time-date
                   tooltip
                   track-changes
                   transient
                   url
                   use-package
                   vc
                   visual-wrap
                   which-key
                   whitespace
                   wid-edit
                   windmove
                   winner
                   word-wrap-mode
                   ;; I don't need these:
                   ;; xt-mouse

                   ;; For elpa modules, eln and preload contradict each other
                   ;; choose carefully which is more important
                   vertico orderless
                   marginalia
                   nerd-icons
                   nerd-icons-completion
                   ligature
                   rainbow-delimiters
                   doom-themes
                   symbol-overlay
                   tree-widget
                   wakatime-mode
                   ;; Not allowed built-ins:
                   ;; password

                   ;; For elpa modules, eln and preload contradict each other
                   ;; choose carefully which is more important

                   ;; breadcrumb cape corfu-terminal eglot
                   ;; embark-consult imenu-list ligature
                   ;; move-text multiple-cursors nerd-icons-completion
                   ;; nerd-icons-corfu nerd-icons-dired nerd-icons-ibuffer
                   ;; rust-mode
                   ;; compat consult corfu dash
                   ;; embark jsonrpc nerd-icons eldoc
                   ;; popon transient with-editor
                    ))
  (require package))
(load-theme 'doom-one t t)

;; dump image
(dump-emacs-portable "c:/Users/hash/AppData/Roaming/.emacs.d/emacs.pdmp")

