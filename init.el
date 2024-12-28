;; -*- lexical-binding: t; -*-
(load "~/.emacs.d/modules/crafted-init-config")

(setq package-archives '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize) ;; You might already have this line

(require 'crafted-completion-packages)
(require 'crafted-ide-packages)
(add-to-list 'package-selected-packages 'powershell)
;; (add-to-list 'package-selected-packages 'yaml-mode)
(add-to-list 'package-selected-packages 'rust-mode)
(add-to-list 'package-selected-packages 'multiple-cursors)
;; (add-to-list 'package-selected-packages 'expand-region)
(add-to-list 'package-selected-packages 'imenu-list)
(add-to-list 'package-selected-packages 'ligature)
;; (add-to-list 'package-selected-packages 'web-mode)
;; (add-to-list 'package-selected-packages 'sublimity)
;; (add-to-list 'package-selected-packages 'sublimity-scroll)
;; (add-to-list 'package-selected-packages 'sublimity-map)
;; (add-to-list 'package-selected-packages 'minimap)
(add-to-list 'package-selected-packages 'adaptive-wrap)
(add-to-list 'package-selected-packages 'which-key)
(add-to-list 'package-selected-packages 'move-text)
(add-to-list 'package-selected-packages 'nerd-icons)
(add-to-list 'package-selected-packages 'nerd-icons-corfu)
(add-to-list 'package-selected-packages 'nerd-icons-dired)
(add-to-list 'package-selected-packages 'nerd-icons-ibuffer)
(add-to-list 'package-selected-packages 'nerd-icons-completion)
(add-to-list 'package-selected-packages 'wakatime-mode)
(add-to-list 'package-selected-packages 'magit)
(add-to-list 'package-selected-packages 'breadcrumb)
(add-to-list 'package-selected-packages 'undo-tree)
;; (add-to-list 'package-selected-packages 'visual-fill-column-mode)

;; (setq create-lockfiles nil)
;; (setq make-backup-files nil)
;; (setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
;;                          ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
;;                          ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))

;; UTF-8
;; https://rufflewind.com/2014-07-20/pasting-unicode-in-emacs-on-windows
(if (eq system-type 'windows-nt)
    (progn
      (set-clipboard-coding-system 'utf-16-le)
      (set-selection-coding-system 'utf-16-le))
  (set-selection-coding-system 'utf-8))
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; WTF? I wish markdown-ts-mode could be built-in
(use-package markdown-ts-mode
  :mode ("\\.md\\'" . markdown-ts-mode)
  :defer 't
  :config
  (add-to-list 'treesit-language-source-alist '(markdown "https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown/src"))
  (add-to-list 'treesit-language-source-alist '(markdown-inline "https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown-inline/src"))
  )

(use-package rainbow-delimiters
  :ensure t
  ;; :hook (prog-mode . #'rainbow-delimiters-mode)
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )

(use-package benchmark-init
  :ensure t
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  ;; (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
  ;; doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)
  :if (window-system)

  ;; Enable flashing mode-line on errors
  ;; (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;; (doom-themes-neotree-config)
  ;; or for treemacs users
  ;; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  ;; (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  ;; (doom-themes-org-config)
  )

;; (use-package catppuccin-theme
;;   :ensure t
;;   :custom (catppuccin-flavor 'macchiato)
;;   :config (load-theme 'catppuccin :no-confirm)
;;   :if (window-system))

(package-install-selected-packages :noconfirm)

(when window-system
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(require 'crafted-defaults-config)
(require 'crafted-completion-config)
(require 'crafted-ide-config)
;; (require 'crafted-ui-config)
;; (require 'crafted-speedbar-config)
;; (require 'crafted-startup-config)

(with-eval-after-load 'eglot
  (if (eq system-type 'windows-nt)
    (progn
      (add-to-list 'eglot-server-programs
                   `(typescript-ts-base-mode
                    .
                    ,(eglot-alternatives '(("typescript-language-server.cmd" "--stdio")
                                            ("vtsls.cmd" "--stdio")
                                            ("deno" "lsp")))))
      (add-to-list 'eglot-server-programs
                   `(js-ts-mode
                    .
                    ,(eglot-alternatives '(("typescript-language-server.cmd" "--stdio")
                                            ("vtsls.cmd" "--stdio")
                                            ("deno" "lsp")))))

      (add-to-list 'eglot-server-programs
                   '((python-ts-mode) . (;; "delance-langserver.cmd" "--stdio"
                                         ;; "deno" "run" "-A" "npm:pyright/pyright-langserver" "--stdio"
                                     ;; "pyright-langserver.cmd" "--stdio"
                                     ;;:initializationOptions
                                         ;;  (:python (:analysis (:typeCheckingMode "strict")))

                                         "pylsp" :initializationOptions
                                         (:pylsp
                                          (:plugins
                                           (:pylsp_mypy (:enabled t
                                                         :strict t))
                                           :ruff (:enabled t)))

                                     ))) ;; basedpyright or delance
      (add-to-list 'eglot-server-programs
                   '(markdown-ts-mode . ("marksman"))) ;; brilliant
      (add-to-list 'eglot-server-programs
               '(c-ts-mode . ("C:\\msys64\\clang64\\bin\\clangd.exe"
                              "--compile-commands-dir=build"
                              "--clang-tidy"
                              "--completion-style=detailed"
                              "--all-scopes-completion"
                              "--background-index"
                              "--header-insertion=iwyu"
                              "--function-arg-placeholders")))
      (add-to-list 'eglot-server-programs
               '(c++-ts-mode . ("C:\\msys64\\clang64\\bin\\clangd.exe"
                                "--compile-commands-dir=build"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--all-scopes-completion"
                                "--background-index"
                                "--header-insertion=iwyu"
                                "--function-arg-placeholders")))
      (add-to-list 'eglot-server-programs
                   '(rust-ts-mode . ("C:\\Users\\hash\\.rustup\\toolchains\\stable-x86_64-pc-windows-gnu\\bin\\rust-analyzer.exe" :initializationOptions
                                 (:cargo
                                  (:extraEnv
                                   (:CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER "C:\\msys64\\ucrt64\\bin\\gcc.exe"
                                    :CARGO_TARGET_X86_64_PC_WINDOWS_GNU_RUSTFLAGS "-C link-arg=-fuse-ld=lld -C target-cpu=x86-64-v3"
                                    :CARGO_TARGET_X86_64_PC_WINDOWS_LLVMGNU_LINKER "C:\\msys64\\clang64\\bin\\clang.exe"
                                    :CARGO_TARGET_X86_64_PC_WINDOWS_LLVMGNU_RUSTFLAGS "-Clink-arg=-fuse-ld=lld -C target-cpu=x86-64-v3"
                                    :CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_LINKER "C:\\msys64\\clang64\\bin\\ld.lld.exe"
                                    :CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_RUSTFLAGS "-C target-feature=+simd128")
                                   ;; :target "x86_64-pc-windows-gnullvm")
                                   :target "x86_64-pc-windows-gnu")
                                  :checkOnSave t
                                  :check (:command "clippy")
                                  :server
                                  (:extraEnv
                                   (:AR_x86_64-pc-windows-gnullvm "C:\\msys64\\clang64\\bin\\llvm-ar.exe"
                                    :CC_x86_64-pc-windows-gnullvm "C:\\msys64\\clang64\\bin\\clang.exe"
                                    :CFLAGS_x86_64-pc-windows-gnullvm "-march=x86-64-v3 -fvisibility=hidden -flto=thin"
                                    :CXX_x86_64-pc-windows-gnullvm "C:\\msys64\\clang64\\bin\\clang++.exe"
                                    :CXXFLAGS_x86_64-pc-windows-gnullvm "-march=x86-64-v3 -fvisibility=hidden -flto=thin")
                                   )
                                  :inlayHints
                                  (:typeHints
                                   (:enable t))
                                  )))))
    (progn
      (add-to-list 'eglot-server-programs
                   '((python-ts-mode) . (;; "delance-langserver.cmd" "--stdio"
                                     "pyright-langserver" "--stdio"
                                     ;;:initializationOptions
                                     ;;  (:python (:analysis (:typeCheckingMode "strict")))
                                     ))) ;; basedpyright or delance
      (add-to-list 'eglot-server-programs
               '(c-ts-mode . ("clangd"
                              "--compile-commands-dir=build"
                              "--clang-tidy"
                              "--completion-style=detailed"
                              "--all-scopes-completion"
                              "--background-index"
                              "--header-insertion=iwyu"
                              "--function-arg-placeholders")))
      (add-to-list 'eglot-server-programs
               '(c++-ts-mode . ("clangd"
                                "--compile-commands-dir=build"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--all-scopes-completion"
                                "--background-index"
                                "--header-insertion=iwyu"
                                "--function-arg-placeholders")))
        (add-to-list 'eglot-server-programs
               '(rust-ts-mode . ("rust-analyzer" :initializationOptions
                                 (:cargo
                                  (:extraEnv
                                   (:CARGO_TARGET_X86_64_PC_WINDOWS_GNU_LINKER "C:\\msys64\\ucrt64\\bin\\gcc.exe"
                                    :CARGO_TARGET_X86_64_PC_WINDOWS_GNU_RUSTFLAGS "-C link-arg=-fuse-ld=lld -C target-cpu=x86-64-v3"
                                    :CARGO_TARGET_X86_64_PC_WINDOWS_LLVMGNU_LINKER "C:\\msys64\\clang64\\bin\\clang.exe"
                                    :CARGO_TARGET_X86_64_PC_WINDOWS_LLVMGNU_RUSTFLAGS "-Clink-arg=-fuse-ld=lld -C target-cpu=x86-64-v3"
                                    :CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_LINKER "C:\\msys64\\clang64\\bin\\ld.lld.exe"
                                    :CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_RUSTFLAGS "-C target-feature=+simd128")
                                   :target "x86_64-unknown-linux-gnu")
                                  :checkOnSave t
                                  :check (:command "clippy")
                                  :server
                                  (:extraEnv
                                   (:AR_x86_64-pc-windows-gnullvm "C:\\msys64\\clang64\\bin\\llvm-ar.exe"
                                    :CC_x86_64-pc-windows-gnullvm "C:\\msys64\\clang64\\bin\\clang.exe"
                                    :CFLAGS_x86_64-pc-windows-gnullvm "-march=x86-64-v3 -fvisibility=hidden -flto=thin"
                                    :CXX_x86_64-pc-windows-gnullvm "C:\\msys64\\clang64\\bin\\clang++.exe"
                                    :CXXFLAGS_x86_64-pc-windows-gnullvm "-march=x86-64-v3 -fvisibility=hidden -flto=thin")
                                   )
                                  :inlayHints
                                  (:typeHints
                                   (:enable t))
                                  ))))
    )))

(add-hook 'c-ts-mode-hook 'eglot-ensure)
(add-hook 'c++-ts-mode-hook 'eglot-ensure)
(add-hook 'rust-ts-mode-hook 'eglot-ensure)
(add-hook 'python-ts-mode-hook 'eglot-ensure)
(add-hook 'js-ts-mode-hook 'eglot-ensure)
(add-hook 'typescript-ts-mode-hook 'eglot-ensure)
(add-hook 'tsx-ts-mode-hook 'eglot-ensure)
(add-hook 'bash-ts-mode-hook 'eglot-ensure)
(add-hook 'go-ts-mode-hook 'eglot-ensure)
(add-hook 'go-mod-ts-mode-hook 'eglot-ensure)
(add-hook 'markdown-ts-mode-hook 'eglot-ensure)
(add-hook 'yaml-ts-mode-hook 'eglot-ensure)
;; (crafted-ide-eglot-auto-ensure-all)
;; (crafted-ide-configure-tree-sitter)
;; (add-to-list 'crafted-ui-line-numbers-enabled-modes 'yaml-mode)
(setq gc-cons-threshold most-positive-fixnum)
;; (remove-hook 'after-init-hook 'recentf-mode)
;; (setq-default word-wrap t)
;; (global-set-key (kbd "C-=") 'er/expand-region)
(load "~/.emacs.d/modules/emt")
(emt-mode)
(global-hl-line-mode)
(global-set-key (kbd "C-<left>") 'emt-backward-word)
(global-set-key (kbd "M-<left>") 'emt-backward-word)
(global-set-key (kbd "C-<right>") 'emt-forward-word)
(global-set-key (kbd "M-<right>") 'emt-forward-word)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-d") 'mc/mark-next-like-this)
(global-set-key (kbd "C-y") 'undo-tree-undo)
(global-set-key (kbd "C-/") 'comment-line)
(global-set-key (kbd "M-F") 'eglot-format)
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key (kbd "C-'") #'imenu-list-smart-toggle)
(move-text-default-bindings)
(add-to-list 'auto-mode-alist '("\\.cxx\\'" . c++-ts-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-ts-mode))

(when window-system
  (pixel-scroll-precision-mode)
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)
  (add-hook 'dired-mode-hook #'nerd-icons-dired-mode)
  (add-hook 'ibuffer-mode-hook #'nerd-icons-ibuffer-mode)
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
                               "\\\\" "://" "----"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t)
  ;; (custom-set-variables
   ;; '(minimap-mode t))
  (global-whitespace-mode t)
 (setq-default whitespace-style '(face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark newline-mark missing-newline-at-eof))
  )


(global-word-wrap-whitespace-mode t)
(which-key-mode)
(global-wakatime-mode)
(breadcrumb-mode)

;; https://www.emacswiki.org/emacs/MoveLine
;; https://github.com/emacsfodder/move-text

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
(setq-default adaptive-fill-regexp "[ 	]*\\([!|•‣⁃◦]+[ 	]*\\)*\\([*-][ 	]\\[[x ]\\)*")
;; (add-hook 'visual-line-mode-hook #'adaptive-wrap-prefix-mode)
;; (global-visual-line-mode +1)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-notify-method 'aggressive t)
 '(bookmark-save-flag 1)
 '(column-number-mode t)
 '(completion-category-overrides '((file (styles partial-completion))))
 '(completion-cycle-threshold 3)
 '(completion-styles '(orderless basic))
 '(completions-detailed t)
 '(context-menu-mode t)
 '(corfu-auto t)
 '(corfu-auto-prefix 2)
 '(corfu-cycle t)
 '(cua-mode t)
 '(cursor-type 'bar)
 '(dictionary-server "dict.org")
 '(dired-auto-revert-buffer t t)
 '(dired-dwim-target t t)
 '(ediff-window-setup-function 'ediff-setup-windows-plain t)
 '(eglot-autoshutdown t t)
 '(electric-pair-mode t)
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
 '(package-archive-priorities
   '(("gnu" . 99)
     ("nongnu" . 80)
     ("stable" . 70)
     ("melpa" . 0)))
 '(package-quickstart t)
 '(package-selected-packages
   '(eglot magit which-key vertico rust-mode powershell orderless multiple-cursors move-text minimap markdown-ts-mode marginalia ligature imenu-list ibuffer-project embark-consult editorconfig corfu-terminal catppuccin-theme cape breadcrumb aggressive-indent adaptive-wrap))
 '(pixel-scroll-precision-interpolate-page t)
 '(ring-bell-function 'ignore)
 '(rust-mode-treesitter-derive t)
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
 '(switch-to-buffer-in-dedicated-window 'pop)
 '(switch-to-buffer-obey-display-actions t)
 '(tab-always-indent 'complete)
 '(treesit-auto-langs
   '(c cpp bash css html python rust javascript typescript json css dockerfile yaml sql toml))
 '(treesit-font-lock-level 4)
 '(vertico-cycle t)
 '(wakatime-cli-path "C:\\Users\\hash\\go\\bin\\wakatime-cli.exe")
 '(whitespace-style
   '(face trailing tabs spaces missing-newline-at-eof empty indentation space-after-tab space-before-tab space-mark tab-mark))
 '(xref-show-definitions-function 'xref-show-definitions-completing-read t)
 '(xterm-mouse-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Cascadia Code" :foundry "outline" :slant normal :weight regular :height 110 :width normal)))))
