(load "~/.emacs.d/modules/crafted-init-config")
(require 'crafted-completion-packages)
(require 'crafted-ide-packages)
(require 'crafted-ui-packages)
(add-to-list 'package-selected-packages 'powershell)
;; (add-to-list 'package-selected-packages 'yaml-mode)
(add-to-list 'package-selected-packages 'rust-mode)
;; (add-to-list 'package-selected-packages 'markdown-mode)
(add-to-list 'package-selected-packages 'markdown-ts-mode)
(add-to-list 'package-selected-packages 'multiple-cursors)
(add-to-list 'package-selected-packages 'expand-region)
(add-to-list 'package-selected-packages 'imenu-list)
(add-to-list 'package-selected-packages 'catppuccin-theme)
(add-to-list 'package-selected-packages 'ligature)
;; (add-to-list 'package-selected-packages 'web-mode)
;; (add-to-list 'package-selected-packages 'sublimity)
;; (add-to-list 'package-selected-packages 'sublimity-scroll)
;; (add-to-list 'package-selected-packages 'sublimity-map)
(add-to-list 'package-selected-packages 'minimap)
(add-to-list 'package-selected-packages 'adaptive-wrap)
;; (add-to-list 'package-selected-packages 'visual-fill-column-mode)

;; (setq create-lockfiles nil)
;; (setq make-backup-files nil)
;; (setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
;;                          ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
;;                          ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))
(setq package-archives '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
			 ("melpa"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;; (package-initialize) ;; You might already have this line

;; WTF? I wish markdown-ts-mode could be built-in
(use-package markdown-ts-mode
  :mode ("\\.md\\'" . markdown-ts-mode)
  :defer 't
  :config
  (add-to-list 'treesit-language-source-alist '(markdown "https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown/src"))
    (add-to-list 'treesit-language-source-alist '(markdown-inline "https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown-inline/src")))
(package-install-selected-packages :noconfirm)

(require 'crafted-defaults-config)
(require 'crafted-completion-config)
(require 'crafted-ide-config)
(require 'crafted-ui-config)
;; (require 'crafted-speedbar-config)
;; (require 'crafted-startup-config)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(typescript-ts-base-mode . ("vtsls.cmd" "--stdio"))) ;; problematic
  (add-to-list 'eglot-server-programs
               '(markdown-ts-mode . ("marksman"))) ;; brilliant
  (add-to-list 'eglot-server-programs
               '(rust-ts-mode . ("rust-analyzer" :initializationOptions
                              (:cargo (:extraEnv (:CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER "C:\\msys64\\ucrt64\\bin\\clang.exe"
                                                  :CARGO_TARGET_X86_64_PC_WINDOWS_GNU_RUSTFLAGS "-C link-arg=-fuse-ld=lld -C target-cpu=x86-64-v3"
                                                  :CARGO_TARGET_X86_64_PC_WINDOWS_LLVMGNU_LINKER "C:\\msys64\\ucrt64\\bin\\clang.exe"
                                                  :CARGO_TARGET_X86_64_PC_WINDOWS_LLVMGNU_RUSTFLAGS "-Clink-arg=-fuse-ld=lld -C target-cpu=x86-64-v3"
                                                  :CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_LINKER "C:\\msys64\\clang64\\bin\\ld.lld.exe"
                                                  :CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_RUSTFLAGS "-C target-feature=+simd128")
                                        :target "x86_64-pc-windows-gnullvm" ;; not working
                                                 ))))))
(setq rust-mode-treesitter-derive t)
(crafted-ide-eglot-auto-ensure-all)
(crafted-ide-configure-tree-sitter '(bash css html python rust javascript typescript json css dockerfile yaml sql toml))
;; (add-to-list 'crafted-ui-line-numbers-enabled-modes 'yaml-mode)
(global-display-line-numbers-mode)
(setq gc-cons-threshold most-positive-fixnum)
;; (setq-default word-wrap t)
(cua-mode t)
(global-set-key (kbd "C-e") 'er/expand-region)
(global-set-key (kbd "C-d") 'mc/mark-next-like-this)
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key (kbd "C-'") #'imenu-list-smart-toggle)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
;; (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-ts-mode))

(when window-system
  (set-frame-width (selected-frame) 140)

  ;; https://emacs-china.org/t/emacs/15676
  ;; (set-fontset-font t '(#x2ff0 . #x9ffc) (font-spec :family "霞鹜文楷" :height 110))
  (set-fontset-font t '(#x2ff0 . #x9ffc) (font-spec :family "Microsoft Yahei UI" :height 110))

 ;; https://github.com/mickeynp/ligature.el
 ;;
 ;; Enable the "www" ligature in every possible major mode
 ;; (ligature-set-ligatures 't '("www"))
 ;; Enable traditional ligature support in eww-mode, if the
 ;; `variable-pitch' face supports it
 (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
 ;; Enable all Cascadia Code ligatures in programming modes
 (ligature-set-ligatures 't '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                      ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                      "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                      "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                      "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                      "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                      "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                      "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                      ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                      "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                      "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                      "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                      "\\\\" "://"))
 ;; Enables ligature checks globally in all buffers. You can also do it
 ;; per mode with `ligature-mode'.
 (global-ligature-mode t)
 (custom-set-variables
  '(minimap-mode t))
 (setq catppuccin-flavor 'macchiato) ;; or 'latte, 'macchiato, or 'mocha
 (load-theme 'catppuccin :no-confirm)
 (global-whitespace-mode t)
 (setq-default whitespace-style '(face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark newline-mark missing-newline-at-eof))
 )


(global-word-wrap-whitespace-mode t)
;; (setq-default adaptive-fill-mode t)
;; (setq-default wrap-prefix "  ")
;; (setq-default fill-prefix "--> ")
;; (adaptive-wrap-prefix-mode)
;; (imenu-list-smart-toggle)
;; https://emacs.stackexchange.com/questions/14589/correct-indentation-for-wrapped-lines
;; (add-hook 'ligature-mode-hook #'whitespace-mode)
(add-hook 'word-wrap-whitespace-mode-hook #'adaptive-wrap-prefix-mode)
(setq-default adaptive-wrap-extra-indent 2)
;; (setq-default adaptive-wrap-prefix-mode t)
;; (setq-default global-adaptive-wrap-prefix-mode 1)
(setq-default adaptive-fill-regexp "[ 	]*\\([-–!|•‣⁃◦]+[ 	]*\\)*")
;; (add-hook 'visual-line-mode-hook #'adaptive-wrap-prefix-mode)
;; (global-visual-line-mode +1)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-notify-method 'aggressive t)
 '(bookmark-save-flag 1)
 '(completion-category-overrides '((file (styles partial-completion))))
 '(completion-cycle-threshold 3)
 '(completion-styles '(orderless basic))
 '(completions-detailed t)
 '(corfu-auto t)
 '(corfu-auto-prefix 2)
 '(corfu-cycle t)
 '(crafted-ui-display-line-numbers t)
 '(dired-auto-revert-buffer t t)
 '(dired-dwim-target t t)
 '(ediff-window-setup-function 'ediff-setup-windows-plain t)
 '(eglot-autoshutdown t)
 '(eshell-scroll-to-bottom-on-input 'this t)
 '(fancy-splash-image
   "c:/Users/hash/AppData/Roaming/.emacs.d/system-crafters-logo.png")
 '(fast-but-imprecise-scrolling t)
 '(global-auto-revert-non-file-buffers t)
 '(global-display-line-numbers-mode t)
 '(ibuffer-movement-cycle nil)
 '(ibuffer-old-time 24)
 '(inhibit-startup-screen t)
 '(kill-do-not-save-duplicates t)
 '(load-prefer-newer t t)
 '(marginalia-annotators
   '(marginalia-annotators-heavy marginalia-annotators-light nil) t)
 '(minimap-major-modes '(yaml-ts-mode markdown-ts-mode prog-mode))
 '(minimap-minimum-width 10)
 '(minimap-mode nil)
 '(minimap-width-fraction 0.1)
 '(minimap-window-location 'right)
 '(package-archive-priorities
   '(("gnu" . 99)
     ("nongnu" . 80)
     ("stable" . 70)
     ("melpa" . 0)))
 '(package-selected-packages
   '(catppuccin-theme ibuffer-project aggressive-indent editorconfig treesit-auto))
 '(scroll-bar-mode nil)
 '(scroll-conservatively 101)
 '(scroll-margin 0)
 '(scroll-preserve-screen-position t)
 '(speedbar-frame-parameters
   '((name . "speedbar")
     (title . "speedbar")
     (minibuffer)
     (border-width . 2)
     (menu-bar-lines . 0)
     (tool-bar-lines . 0)
     (unsplittable . t)
     (left-fringe . 10)))
 '(speedbar-update-flag t)
 '(speedbar-use-images nil)
 '(switch-to-buffer-in-dedicated-window 'pop)
 '(switch-to-buffer-obey-display-actions t)
 '(tab-always-indent 'complete)
 '(treesit-auto-langs
   '(bash css html python rust javascript typescript json css dockerfile yaml sql toml))
 '(vertico-cycle t)
 '(xref-show-definitions-function 'xref-show-definitions-completing-read))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Cascadia Code" :foundry "outline" :slant normal :weight regular :height 110 :width normal)))))
