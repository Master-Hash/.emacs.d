;; -*- lexical-binding: t; -*-

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Cascadia Code" :foundry "outline" :slant normal :weight normal :height 110 :width normal)))))

(when window-system
  (progn
    (pixel-scroll-precision-mode)
    ;; (global-tab-line-mode)
    ;; (global-hl-line-mode)
    ;; (set-frame-width (selected-frame) 140)
    (add-to-list 'default-frame-alist '(fullscreen . maximized))
    ;; https://emacs-china.org/t/emacs/15676
    ;; (set-fontset-font t '(#x2ff0 . #x9ffc) (font-spec :family "霞鹜文楷" :height 110))
    (set-fontset-font t '(#x2ff0 . #x9ffc) (font-spec :family "Microsoft Yahei UI" :height 110))
    ;; (custom-set-variables
    ;; '(minimap-mode t))
    (global-whitespace-mode t)
    ;; (setq-default whitespace-style '(face tabs spaces trailing space-before-tab newline indentation empty space-after-tab tab-mark newline-mark missing-newline-at-eof))
    )
  (xterm-mouse-mode)
  (global-window-tool-bar-mode))

(global-word-wrap-whitespace-mode t)
(global-visual-wrap-prefix-mode)
(global-visual-line-mode 't)
(global-completion-preview-mode)
(which-key-mode)

(defvar luna-dumped nil
  "non-nil when a dump file is loaded.
(Because dump.el sets this variable).")

(defmacro luna-if-dump (then &rest else)
  "Evaluate IF if running with a dump file, else evaluate ELSE."
  (declare (indent 1))
  `(if luna-dumped
       ,then
     ,@else))

(luna-if-dump
    (progn
      (setq load-path luna-dumped-load-path)
      (menu-bar-mode)
      (tool-bar-mode)
      (global-font-lock-mode)
      (transient-mark-mode)
      (add-hook 'after-init-hook
                (lambda ()
                  (save-excursion
                    (switch-to-buffer "*scratch*")
                    (lisp-interaction-mode))))
      )
  ;; add load-path’s and load autoload files
  (package-initialize)
  (load "~/.emacs.d/modules/crafted-init-config")
  )

(luna-if-dump
    (when window-system
      (enable-theme 'doom-one))
  (use-package doom-themes
    :ensure t
    :config
    (load-theme 'doom-one t)
    :if (window-system)))

;; (package-initialize) ;; You might already have this line

;; (require 'crafted-completion-packages)
;; (require 'crafted-ide-packages)
;; (add-to-list 'package-selected-packages 'powershell)
;; ;; (add-to-list 'package-selected-packages 'yaml-mode)
;; (add-to-list 'package-selected-packages 'rust-mode)
;; (add-to-list 'package-selected-packages 'multiple-cursors)
;; ;; (add-to-list 'package-selected-packages 'expand-region)
;; (add-to-list 'package-selected-packages 'imenu-list)
;; ;; (add-to-list 'package-selected-packages 'web-mode)
;; ;; (add-to-list 'package-selected-packages 'sublimity)
;; ;; (add-to-list 'package-selected-packages 'sublimity-scroll)
;; ;; (add-to-list 'package-selected-packages 'sublimity-map)
;; ;; (add-to-list 'package-selected-packages 'minimap)
;; (add-to-list 'package-selected-packages 'move-text)
;; (add-to-list 'package-selected-packages 'wakatime-mode)
;; (add-to-list 'package-selected-packages 'magit)
;; (add-to-list 'package-selected-packages 'breadcrumb)
;; ;; (add-to-list 'package-selected-packages 'vundo)
;; ;; (add-to-list 'package-selected-packages 'visual-fill-column-mode)

;; (setq create-lockfiles nil)
;; (setq make-backup-files nil)
;; (setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
;;                          ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
;;                          ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))

;; UTF-8
;; https://rufflewind.com/2014-07-20/pasting-unicode-in-emacs-on-windows
(if (eq system-type 'windows-nt)
    (progn
      (when window-system (set-frame-parameter nil 'alpha 0.96))
      (setq default-directory (concat (getenv "APPDATA") "\\..\\..\\"))
      (setq wakatime-cli-path "%APPDATA%\\..\\..\\go\\bin\\wakatime-cli.exe")
      ;; (setq ispell-alternate-dictionary "~/../../Documents/The_Chambers_Thesaurus.txt")
      (set-clipboard-coding-system 'utf-16-le)
      (set-selection-coding-system 'utf-16-le))
  (set-selection-coding-system 'utf-8))
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; https://github.com/minad/corfu#configuration
(use-package emacs
  :custom
  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (text-mode-ispell-word-completion nil))

(use-package ligature
  :ensure t
  :config
  ;; `https://github.com/mickeynp/ligature.el'
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
  :when window-system)

(use-package nerd-icons
  :ensure
  :defer t
  :when window-system)

(use-package nerd-icons-corfu
  :ensure
  :defer t
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)
  :when window-system)

(use-package nerd-icons-dired
  :ensure
  :defer t
  :hook (dired-mode . nerd-icons-dired-mode)
  :when window-system)

(use-package nerd-icons-ibuffer
  :ensure
  :defer t
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode)
  :when window-system)

(use-package nerd-icons-completion
  :ensure
  :defer t
  :hook (marginalia-mode . nerd-icons-completion-marginalia-setup)
  :when window-system)

(use-package symbol-overlay
  ;; :ensure
  ;; I prefer eglot qaq
  ;;`https://github.com/wolray/symbol-overlay/issues/82'
  :hook ((emacs-lisp-mode . symbol-overlay-mode)))

;; inactive maintain
;; (use-package ace-window
;;   :ensure
;;   :bind (("M-o" . ace-window)))

(use-package breadcrumb
  :ensure
  :defer t
  :hook ((eglot-managed-mode . breadcrumb-mode)))

;; WTF? I wish markdown-ts-mode could be built-in
(use-package markdown-ts-mode
  :mode ("\\.md\\'" . markdown-ts-mode)
  :defer t
  :config
  (add-to-list 'treesit-language-source-alist '(markdown "https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown/src"))
  (add-to-list 'treesit-language-source-alist '(markdown-inline "https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown-inline/src"))
  )

(use-package powershell-ts-mode
  :vc (:url "git@github.com:dmille56/powershell-ts-mode.git"
            :branch "main"
            :rev :newest)
  :mode ("\\.ps1\\'" . powershell-ts-mode)
  :defer t)

(use-package move-text
  ;; `https://www.emacswiki.org/emacs/MoveLine'
  ;; `https://github.com/emacsfodder/move-text'
  :ensure
  :defer t
  :bind (("M-<up>" . move-text-up)
         ("M-<down>" . move-text-down)))

(use-package expand-region
  :ensure
  :bind (("C-=" . er/expand-region)))

(use-package multiple-cursors
  :ensure
  :bind (("C-d" . mc/mark-next-like-this)
         ("M-<mouse-1>" . mc/add-cursor-on-click)
         ("C-M-<up>" . mc/mark-previous-lines)
         ("C-M-<down>" . mc/mark-next-lines))
  :config
  (global-unset-key (kbd "M-<down-mouse-1>")))

(use-package imenu-list
  :ensure
  :bind (("C-'" . imenu-list-smart-toggle)
         ("C-c b" . imenu-list-smart-toggle)))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; (use-package benchmark-init
;;   :ensure t
;;   ;; :disabled
;;   :config
;;   ;; To disable collection of benchmark data after init is done.
;;   (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package emt
  :vc (:url "git@github.com:roife/emt.git"
            :branch "master"
            :rev :newest)
  :defer t
  :config
  (emt-ensure)
  :bind (([remap forward-word] . emt-forward-word)
         ([remap backward-word] . emt-backward-word)
         ([remap kill-word] . emt-kill-word)
         ([remap backward-kill-word] . emt-backward-kill-word)
         ([remap word-at-point] . emt-word-at-point-or-forward)
         ("C-<left>" . emt-backward-word)
         ("M-<left>" . emt-backward-word)
         ("C-<right>" . emt-forward-word)
         ("M-<right>" . emt-forward-word)))

;; (use-package catppuccin-theme
;;   :ensure t
;;   :custom (catppuccin-flavor 'macchiato)
;;   :config (load-theme 'catppuccin :no-confirm)
;;   :if (window-system))

;; (package-install-selected-packages :noconfirm)

(use-package eglot
  :defer t
  :hook ((c-ts-mode c++-ts-mode rust-ts-mode
          python-ts-mode js-ts-mode
          typescript-ts-mode tsx-ts-mode
          bash-ts-mode go-ts-mode
          go-mod-ts-mode markdown-ts-mode
          yaml-ts-mode powershell-ts-mode) . eglot-ensure)
  ;; :bind ("M-F" . eglot-format)
  :bind (:map eglot-mode-map
              ("M-F" . eglot-format))
  :config
  ;; (define-key eglot--managed-mode (kbd "M-F") #'eglot-format)
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
                   '(powershell-ts-mode . ("pwsh" "-NoLogo"
                                        "-NoProfile"
                                        "-Command"
                                        "~/PowerShellEditorServices/PowerShellEditorServices/Start-EditorServices.ps1 -Stdio")))
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
                                  )))
    ))
)

(require 'crafted-defaults-config)
(require 'crafted-completion-config)
;; (require 'crafted-ide-config)
;; (require 'crafted-ui-config)
;; (require 'crafted-speedbar-config)
;; (require 'crafted-startup-config)


;; (remove-hook 'after-init-hook 'recentf-mode)
;; (setq-default word-wrap t)
;; (global-set-key (kbd "C-=") 'er/expand-region)
;; (global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-y") #'undo-redo)
(global-set-key (kbd "C-/") #'comment-line)
(global-set-key (kbd "M-p") #'scroll-down-line)
(global-set-key (kbd "M-n") #'scroll-up-line)
;; (global-set-key (kbd "C-<tab>") #'tab-line-switch-to-next-tab)
;; (global-set-key (kbd "C-S-<tab>") #'tab-line-switch-to-prev-tab)
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-ts-mode))
(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-ts-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-ts-mode))
(global-set-key (kbd "C-c i")
                (lambda ()
                  (interactive)
                  (find-file user-init-file)))

(defun custom-scratch-buffer-create ()
  "Open a new empty buffer.
URL `https://emacs.stackexchange.com/questions/5957/rename-scratch-buffer-and-ask-confirmation-to-kill-non-file-buffers-created-by-u'
URL `http://ergoemacs.org/emacs/emacs_new_empty_buffer.html'
Version 2016-08-11"
  (interactive)
  (let ((-buf (generate-new-buffer "untitled")))
    (switch-to-buffer -buf)
    (funcall initial-major-mode)
    (setq buffer-offer-save t)
    (set (make-local-variable 'custom-scratch-buffer) t))) ;; I added this line

(defun custom-scratch-buffer-kill-query-function ()
  (if (and (not buffer-file-name)           ;; buffer is not visiting a file
           (buffer-modified-p)              ;; buffer has been modified
           (boundp 'custom-scratch-buffer))
      (if 'custom-scratch-buffer            ;; buffer is a custom scratch created buffer
          (yes-or-no-p "Scratch buffer modified. Kill it anyway? "))
    t))

;; run query before killing if buffer is custom-scratch-buffer
(add-to-list 'kill-buffer-query-functions #'custom-scratch-buffer-kill-query-function)
(global-set-key (kbd "C-c n") #'custom-scratch-buffer-create)

;; `https://caiorss.github.io/Emacs-Elisp-Programming/Emacs_On_Windows.html'
;; (defun run-powershell ()
;;   "Run powershell"
;;   (interactive)
;;   (async-shell-command "c:/Users/hash/AppData/Local/Microsoft/WindowsApps/pwsh.exe -Command -"
;;                nil
;;                nil))

;; `https://emacs.stackexchange.com/questions/30414/how-to-move-the-cursor-to-the-beginning-end-of-a-shift-selected-region-by-a-left'
(defvar my-old-region-bounds nil)

(advice-add 'handle-shift-selection :around
  (lambda (orig-fun)
    (let ((was-active (region-active-p)))
      (funcall orig-fun)
      (when (and was-active (not (region-active-p)))
        (setq-local my-old-region-bounds
                    (cons (point-marker) (mark-marker)))
        (add-hook 'post-command-hook #'my-move-to-old-region-bound)))))

(defun my-move-to-old-region-bound ()
  (remove-hook 'post-command-hook #'my-move-to-old-region-bound)
  (let ((bounds my-old-region-bounds))
    (kill-local-variable 'my-old-region-bounds)
    (when bounds
      (when (funcall (cond
                      ((> (point) (car bounds)) #'<)
                      ((= (point) (car bounds)) #'=)
                      (t #'>))
                     (point) (cdr bounds))
          ;; We moved towards the other (old)boundary.
        (goto-char (cdr bounds)))
      ;; Hash defines a similar rule
      (when (funcall (cond
                      ((> (point) (car bounds)) #'>)
                      ((= (point) (car bounds)) #'=)
                      (t #'<))
                     (point) (cdr bounds))
        ;; We moved towards the other (old)boundary.
        (goto-char (car bounds)))
      )))

(setq-default adaptive-fill-regexp "[ 	]*\\([!|•‣⁃◦]+[ 	]*\\)*\\([*-][ 	]\\[[x ]\\)*")
(global-wakatime-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-notify-method 'aggressive t)
 '(bookmark-save-flag 1 t)
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
 '(delete-selection-mode t)
 '(dictionary-server "dict.org")
 '(dired-auto-revert-buffer t t)
 '(dired-dwim-target t t)
 '(ediff-window-setup-function 'ediff-setup-windows-plain t)
 '(eglot-autoshutdown t)
 '(electric-pair-mode t)
 '(eshell-scroll-to-bottom-on-input 'this t)
 '(fast-but-imprecise-scrolling t)
 '(flymake-show-diagnostics-at-end-of-line 'short)
 '(global-auto-revert-non-file-buffers t)
 '(global-display-line-numbers-mode t)
 '(ibuffer-movement-cycle nil t)
 '(ibuffer-old-time 24 t)
 '(imenu-flatten 'annotation)
 '(inhibit-startup-screen t)
 '(ispell-dictionary "en")
 '(kill-do-not-save-duplicates t)
 '(load-prefer-newer t)
 '(marginalia-annotators
   '(marginalia-annotators-heavy marginalia-annotators-light nil) t)
 '(package-archive-priorities '(("gnu" . 99) ("nongnu" . 80) ("melpa" . 70)))
 '(package-quickstart t)
 '(package-selected-packages nil)
 '(package-vc-selected-packages '((emt :url "git@github.com:roife/emt.git")))
 '(pixel-scroll-precision-interpolate-page t)
 '(read-extended-command-predicate 'command-completion-default-include-p)
 '(ring-bell-function 'ignore)
 '(rust-mode-treesitter-derive t)
 '(scroll-bar-mode nil)
 '(scroll-conservatively 101)
 '(scroll-margin 0)
 '(scroll-preserve-screen-position t)
 '(speedbar-frame-parameters
   '((name . "speedbar") (title . "speedbar") (minibuffer)
     (border-width . 2) (menu-bar-lines . 0) (tool-bar-lines . 0)
     (unsplittable . t) (left-fringe . 10)))
 '(switch-to-buffer-in-dedicated-window 'pop)
 '(switch-to-buffer-obey-display-actions t)
 '(tab-always-indent 'complete)
 '(treesit-auto-langs
   '(c cpp bash css html python rust javascript typescript json css
       dockerfile yaml sql toml))
 '(treesit-font-lock-level 4)
 '(vertico-cycle t)
 '(visual-wrap-extra-indent 2)
 '(whitespace-style
   '(face trailing tabs spaces indentation space-after-tab
          space-before-tab tab-mark))
 '(xref-show-definitions-function 'xref-show-definitions-completing-read t))

