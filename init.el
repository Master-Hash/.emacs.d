;; -*- lexical-binding: t; -*-

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Cascadia Code" :foundry "outline" :slant normal :weight normal :height 110 :width normal)))))

(if window-system
  (progn
    (pixel-scroll-precision-mode +1)
    (blink-cursor-mode +1)
    ;; (global-tab-line-mode)
    ;; (global-hl-line-mode)
    ;; (set-frame-width (selected-frame) 140)
    ;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
    ;; `https://emacs-china.org/t/emacs/15676'
    ;; `https://casouri.github.io/note/2019/emacs-%E5%AD%97%E4%BD%93%E4%B8%8E%E5%AD%97%E4%BD%93%E9%9B%86/index.html'
    ;; (set-fontset-font t '(#x2ff0 . #x9ffc) (font-spec :family "霞鹜文楷" :height 110))
    ;; (set-fontset-font t '(#x2ff0 . #x9ffc) (font-spec :family "Microsoft Yahei UI" :height 110))
    (set-fontset-font t 'han (font-spec :family "Microsoft Yahei UI" :height 110))
    ;; (set-fontset-font t 'han (font-spec :family "Noto Sans SC" :height 110))
    ;; `https://github.com/ryanoasis/nerd-fonts/wiki/Glyph-Sets-and-Code-Points'
    (set-fontset-font t '(#xe5fa . #xe6b7) (font-spec :family "Symbols Nerd Font Mono" :height 110))
    (set-fontset-font t '(#xe700 . #xe8ef) (font-spec :family "Symbols Nerd Font Mono" :height 110))
    (set-fontset-font t '(#xea60 . #xec1e) (font-spec :family "Symbols Nerd Font Mono" :height 110))
    (set-fontset-font t '(#xf000 . #xf2ff) (font-spec :family "Symbols Nerd Font Mono" :height 110))
    (set-fontset-font t '(#xf400 . #xf4a9) (font-spec :family "Symbols Nerd Font Mono" :height 110))
    (set-fontset-font t '(#xf0001 . #xf1af0) (font-spec :family "Symbols Nerd Font Mono" :height 110))
    (global-whitespace-mode t)
    ;; (setq-default whitespace-style '(face tabs spaces trailing space-before-tab newline indentation empty space-after-tab tab-mark newline-mark missing-newline-at-eof))
    )
  (xterm-mouse-mode)
  (global-window-tool-bar-mode)
  (tool-bar-mode))

;; (setopt vc-handled-backends nil)
(if (null (cdr command-line-args))
    (setopt vc-handled-backends nil)
  (setopt vc-handled-backends '(Git)))

(global-word-wrap-whitespace-mode t)
(global-visual-line-mode t)
(global-visual-wrap-prefix-mode)
;; (add-hook 'visual-wrap-prefix-mode-hook (lambda ()
;;                                           (setq-local mouse-wheel-tilt-scroll nil)))
;; `https://github.com/minad/vertico/issues/278'
;; `https://www.emacswiki.org/emacs/VisualLineMode'
(add-hook 'minibuffer-setup-hook (lambda ()
                                   (visual-line-mode -1)))
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
      (setq native-comp-enable-subr-trampolines t)
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
      (setopt wakatime-cli-path "C:\\msys64\\clang64\\bin\\wakatime.exe")
      ;; (setq ispell-alternate-dictionary "~/../../Documents/The_Chambers_Thesaurus.txt")
      (set-clipboard-coding-system 'utf-16-le)
      (set-selection-coding-system 'utf-16-le))
  (set-selection-coding-system 'utf-8))
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; https://github.com/minad/corfu#configuration
(use-package emacs
  :hook ((dired-mode . (lambda ()
                         (whitespace-mode -1))))
  :custom
  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (text-mode-ispell-word-completion nil)
  (word-wrap-by-category t)
  ;; (mouse-wheel-tilt-scroll t)

  (mouse-wheel-progressive-speed nil) ;; fix pixel-scroll-precision
  )

(when (and (getenv "WSL_INTEROP")
           (not window-system))
  (use-package xclip
    :ensure t
    :config
    ;; 这玩意实际上会被无视
    ;; 但是得留着让启动模式不报错
    ;; 实际上复制用 clip.exe
    ;; 粘贴用 powershell.exe -Command Get-Clipboard
    (setopt xclip-program "clip.exe")

    ;; 我认为很不严谨，应该加上 -NoProfile -NonInteractive 等等
    ;; 而且应该用 pwsh！
    ;; 划掉，pwsh 的冷启动慢死仙人
    (advice-add 'xclip-get-selection :around
                (lambda (orig-fun type)
                  (if (and (eq xclip-method 'powershell)
                           (memq type '(clipboard CLIPBOARD)))
                      ;; 使用我们自己的 PowerShell 命令调用，替换硬编码的 powershell.exe
                      (with-output-to-string
                        (let ((coding-system-for-read 'dos)) ;转换 CR->LF
                          (call-process "powershell.exe" nil `(,standard-output nil) nil
                                        "-NoProfile" "-NonInteractive" "-Command" "Get-Clipboard")))
                    ;; 否则使用原始函数
                    (funcall orig-fun type))))

    ;; 删除末尾换行符
    (advice-add 'xclip-get-selection :filter-return
                (lambda (text)
                  (if (and (eq xclip-method 'powershell)
                           (stringp text)
                           (string-match-p "\n\\'" text))
                      (substring text 0 -1)  ;; 去掉末尾的换行符
                    text)))

    (xclip-mode)))

(use-package wakatime-mode
  :ensure t)

(use-package ligature
  :ensure t
  :config
  ;; `https://github.com/mickeynp/ligature.el'
  (ligature-set-ligatures 't
                          '(;; == === ==== => =| =>>=>=|=>==>> ==< =/=//=// =~
                            ;; =:= =!=
                            ("=" (rx (+ (or ">" "<" "|" "/" "~" ":" "!" "="))))
                            ;; ;; ;;;
                            (";" (rx (+ ";")))
                            ;; && &&&
                            ("&" (rx (+ "&")))
                            ;; !! !!! !. !: !!. != !== !~
                            ("!" (rx (+ (or "=" "!" "\." ":" "~"))))
                            ;; ?? ??? ?:  ?=  ?.
                            ("?" (rx (or ":" "=" "\." (+ "?"))))
                            ;; %% %%%
                            ("%" (rx (+ "%")))
                            ;; |> ||> |||> ||||> |] |} || ||| |-> ||-||
                            ;; |->>-||-<<-| |- |== ||=||
                            ;; |==>>==<<==<=>==//==/=!==:===>
                            ("|" (rx (+ (or ">" "<" "|" "/" ":" "!" "}" "\]"
                                            "-" "=" ))))
                            ;; \\ \\\ \/
                            ("\\" (rx (or "/" (+ "\\"))))
                            ;; ++ +++ ++++ +>
                            ("+" (rx (or ">" (+ "+"))))
                            ;; :: ::: :::: :> :< := :// ::=
                            (":" (rx (or ">" "<" "=" "//" ":=" (+ ":"))))
                            ;; // /// //// /\ /* /> /===:===!=//===>>==>==/
                            ("/" (rx (+ (or ">"  "<" "|" "/" "\\" "\*" ":" "!"
                                            "="))))
                            ;; .. ... .... .= .- .? ..= ..<
                            ("\." (rx (or "=" "-" "\?" "\.=" "\.<" (+ "\."))))
                            ;; -- --- ---- -~ -> ->> -| -|->-->>->--<<-|
                            ("-" (rx (+ (or ">" "<" "|" "~" "-"))))
                            ;; *> */ *)  ** *** ****
                            ("*" (rx (or ">" "/" ")" (+ "*"))))
                            ;; www wwww
                            ;; ("w" (rx (+ "w")))
                            ;; <> <!-- <|> <: <~ <~> <~~ <+ <* <$ </  <+> <*>
                            ;; <$> </> <|  <||  <||| <|||| <- <-| <-<<-|-> <->>
                            ;; <<-> <= <=> <<==<<==>=|=>==/==//=!==:=>
                            ;; << <<< <<<<
                            ("<" (rx (+ (or "\+" "\*" "\$" "<" ">" ":" "~"  "!"
                                            "-"  "/" "|" "="))))
                            ;; >: >- >>- >--|-> >>-|-> >= >== >>== >=|=:=>>
                            ;; >> >>> >>>>
                            (">" (rx (+ (or ">" "<" "|" "/" ":" "=" "-"))))
                            ;; #: #= #! #( #? #[ #{ #_ #_( ## ### #####
                            ("#" (rx (or ":" "=" "!" "(" "\?" "\[" "{" "_(" "_"
                                         (+ "#"))))
                            ;; ~~ ~~~ ~=  ~-  ~@ ~> ~~>
                            ("~" (rx (or ">" "=" "-" "@" "~>" (+ "~"))))
                            ;; __ ___ ____ _|_ __|____|_
                            ("_" (rx (+ (or "_" "|"))))
                            ;; Fira code: 0xFF 0x12
                            ;; ("0" (rx (and "x" (+ (in "A-F" "a-f" "0-9")))))
                            ;; Fira code:
                            ;; "Fl"  "Tl"  "fi"  "fj"  "fl"  "ft"
                            ;; The few not covered by the regexps.
                            "{|"  "[|"  "]#"  "(*"  "}#"  "$>"  "^="))
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

;; (use-package nerd-icons-dired
;;   :ensure
;;   :defer t
;;   :hook (dired-mode . nerd-icons-dired-mode)
;;   :when window-system)

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

(use-package doom-modeline
  :ensure t
  :init
  (setopt doom-modeline-project-detection 'project)
  (setopt doom-modeline-enable-word-count t)
  (setopt doom-modeline-buffer-file-name-style 'relative-from-project)
  ;; (setopt doom-modeline-project-name t)
  (setopt doom-modeline-lsp nil)
  (doom-modeline-mode 1)
  (add-to-list
   'mode-line-misc-info
   `(eglot--managed-mode (" [" eglot--mode-line-format "] "))
   ))

;; (use-package minimap
;;   :ensure t
;;   :config
;;   (setq minimap-minimum-width 10)
;;   (setq minimap-width-fraction 0.1)
;;   (setq minimap-window-location 'right)
;;   (minimap-mode +1)
;;   :when window-system)

(use-package symbol-overlay
  :ensure
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
  :mode ("\\.md\\'" . markdown-ts-mode))

;; (use-package powershell-ts-mode
;;   :vc (:url "git@github.com:dmille56/powershell-ts-mode.git"
;;             :branch "main"
;;             :rev :newest)
;;   :mode ("\\.ps1\\'" . powershell-ts-mode)
;;   :defer t)

(use-package move-text
  ;; `https://www.emacswiki.org/emacs/MoveLine'
  ;; `https://github.com/emacsfodder/move-text'
  :ensure
  :defer t
  :bind (("M-<up>" . move-text-up)
         ("M-<down>" . move-text-down)))

;; (use-package expand-region
;;   :ensure
;;   :bind (("C-=" . er/expand-region)))

(use-package expreg
  ;; :vc (:url "git@github.com:casouri/expreg.git"
  ;;           :branch "master"
  ;;           :rev :newest)
  :ensure
  :bind (("C-=" . expreg-expand)
         ("C--" . expreg-contract)))

(use-package multiple-cursors
  :ensure
  :bind (("C-d" . mc/mark-next-like-this)
         ("M-<mouse-1>" . mc/add-cursor-on-click)
         ("C-M-<up>" . mc/mark-previous-lines)
         ("C-M-<down>" . mc/mark-next-lines))
  :config
  (global-unset-key (kbd "M-<down-mouse-1>")))

;; (use-package ultra-scroll
;;   :vc (:url "git@github.com:jdtsmith/ultra-scroll.git"
;;             :branch "master"
;;             :rev :newest)
;;   :ensure
;;   :init
;;   (setq scroll-conservatively 101 ; important!
;;         scroll-margin 0)
;;   :config
;;   (ultra-scroll-mode 1))

(use-package imenu-list
  :ensure
  :bind (("C-'" . imenu-list-smart-toggle)
         ;; ("C-c i" . imenu-list-smart-toggle)
         ))



(use-package dirvish
  ;; `https://github.com/alexluigit/dirvish/blob/main/docs/CUSTOMIZING.org'
  :vc (:url "git@github.com:alexluigit/dirvish.git"
            :branch "main"
            :rev :newest)
  :ensure
  :after vc-git
  :commands (dired dirvish)
  :bind (("C-c d" . dirvish-side))
  :init
  (push "c:/Users/hash/AppData/Roaming/.emacs.d/elpa/dirvish/extensions" load-path)
  (dirvish-override-dired-mode)
  :config
  (require 'dirvish-side)
  (require 'dirvish-vc)
  (require 'dirvish-rsync)
  (require 'dirvish-narrow)
  (require 'dirvish-quick-access)
  (require 'dirvish-history)
  (require 'dirvish-ls)
  (require 'dirvish-emerge)
  (setopt dirvish-attributes           ; The order *MATTERS* for some attributes
          '(vc-state subtree-state nerd-icons collapse git-msg file-time file-size)
          dirvish-side-attributes
          '(vc-state nerd-icons collapse file-size)))

;; (defun hash--dired-sidebar-mouse-subtree-toggle-or-find-file (event)
;;   "Handle a mouse click EVENT in `dired-sidebar'.

;; For directories, if `dired-sidebar-cycle-subtree-on-click' is true,
;; cycle the directory.

;; Otherwise, behaves the same as if user clicked on a file.

;; For files, use `dired-sidebar-find-file'.

;; This uses the same code as `dired-mouse-find-file-other-window' to find
;; the relevant file-directory clicked on by the mouse."
;;   (interactive "e")
;;   (let (window pos file)
;;     (save-excursion
;;       (setq window (posn-window (event-end event))
;;             pos (posn-point (event-end event)))
;;       (if (not (windowp window))
;;           (error "No file chosen"))
;;       (set-buffer (window-buffer window))
;;       (goto-char pos)
;;       (setq file (dired-get-file-for-visit)))
;;     (with-selected-window window
;;       (if (and dired-sidebar-cycle-subtree-on-click
;;                (file-directory-p file)
;;                (not (string-suffix-p "." file)))
;;           (dired-sidebar-subtree-toggle)
;;         (dired-sidebar-find-file file)))))

;; (use-package dired-sidebar
;;   :ensure
;;   :commands (dired-sidebar-toggle-sidebar)
;;   :bind (("C-c d" . dired-sidebar-toggle-sidebar)
;;          (:map dired-sidebar-mode-map
;;                ("C-M-d" . dired-subtree-down)
;;                ("C-M-n" . dired-subtree-next-sibling)
;;                ("C-M-p" . dired-subtree-previous-sibling)
;;                ("C-M-u" . dired-subtree-up)
;;                ;; ("<mouse-1>" . hash--dired-sidebar-mouse-subtree-toggle-or-find-file)
;;                ;; ("<down-mouse-1>" . nil)
;;                ;; ("<mouse-2>" . nil)
;;                ("<mouse-2>" . hash--dired-sidebar-mouse-subtree-toggle-or-find-file)
;;                ))
;;   :custom ((dired-sidebar-use-custom-font t))
;;   ;; :custom-face (dired-sidebar-face ((t (:height 70))))
;;   :hook ((dired-sidebar-mode . (lambda ()
;;                                  (display-line-numbers-mode -1)
;;                                  (visual-wrap-prefix-mode -1)
;;                                  (visual-line-mode -1)
;;                                  (whitespace-mode -1)))
;;          (dired-sidebar-mode . (lambda ()
;;                                  (setq-local mouse-wheel-tilt-scroll t))))
;;   :config
;;   (setq dired-sidebar-face `(:family "Noto Sans SC" :height 100))
;;   (setq dired-sidebar-width 25))

;; (use-package ibuffer-sidebar
;;   :ensure
;;   :commands (ibuffer-sidebar-toggle-sidebar)
;;   :bind ("C-c b" . ibuffer-sidebar-toggle-sidebar))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package vundo
  :ensure t
  :bind (("C-c u" . vundo)))

(use-package vc-git
  :defer 0.1 ;; the exact time is irrelevant, loading happens when open any file
  :config
  (setopt vc-handled-backends '(Git)))

(use-package diff-hl
  :after vc-git
  :ensure
  :custom
  (diff-hl-flydiff-delay 0.1)
  :config
  (global-diff-hl-mode t)
  (diff-hl-flydiff-mode t)
  (global-diff-hl-show-hunk-mouse-mode t)
  (unless (window-system) (diff-hl-margin-mode t)))

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

(use-package python-ts-mode
  :mode "\\.py\\'"
  :hook (python-ts-mode . (lambda ()
                            (setq-local display-fill-column-indicator-column 80)
                            (display-fill-column-indicator-mode))))
  ;; :init
  ;; (add-hook 'python-ts-mode-hook (apply-partially
  ;;                                 #'setq-local display-fill-column-indicator-column
(use-package rust-ts-mode
  :mode "\\.rs\\'"
  ;; (display-fill-column-indicator-mode t)
  :hook (rust-ts-mode . (lambda ()
                          (setq-local display-fill-column-indicator-column 100)
                          (display-fill-column-indicator-mode)))
  ;; :init
  ;; (add-hook 'rust-ts-mode-hook (apply-partially
  ;;                                 #'setq-local display-fill-column-indicator-column 100))
  )

;; (define-derived-mode lalrpop-mode rust-ts-mode "Lalrpop")
;; (add-to-list 'auto-mode-alist '("\\.lalrpop\\'" . lalrpop-mode))

;; I don't know why...
;; (use-package elm-mode
;;   :ensure
;;   :mode "\\.lalrpop\\'")

(use-package magit
  :ensure t
  :defer t
  :after nerd-icons
  :hook ((magit-post-refresh . diff-hl-magit-post-refresh))
  :config
  (when (eq system-type 'windows-nt)
    (setopt magit-git-executable "C:/msys64/clang64/bin/git.exe"))
  :custom
  ((magit-format-file-function #'magit-format-file-nerd-icons)))

(use-package eglot
  :defer t
  :hook ((c-ts-mode c++-ts-mode
          python-ts-mode js-ts-mode rust-ts-mode
          typescript-ts-mode tsx-ts-mode
          bash-ts-mode go-ts-mode
          go-mod-ts-mode markdown-ts-mode
          yaml-ts-mode
          ;; powershell-ts-mode
          ) . eglot-ensure)
  ;; :hook ((rust-ts-mode) . (lambda ()
  ;;                           (message "%s" major-mode)
  ;;                           (unless (eq major-mode 'lalrpop-mode)
  ;;                             (eglot-ensure))))
  ;; :bind ("M-F" . eglot-format)
  :bind (:map eglot-mode-map
              ("M-F" . eglot-format))
  :config
  (setq-default eglot-workspace-configuration
                '(:typescript
                  (:format
                   (:indentSize 2
                    :semicolons "insert"))))
  ;; (define-key eglot--managed-mode (kbd "M-F") #'eglot-format)
  (if (eq system-type 'windows-nt)
    (progn
      (add-to-list 'eglot-server-programs
                   `(typescript-ts-base-mode
                    .
                    ,(eglot-alternatives '(("typescript-language-server.cmd" "--stdio"
                                            :initializationOptions
                                            (:preferences
                                             (:quotePreference "double"
                                              :importModuleSpecifier "relative"
                                              :importModuleSpecifierEnding "js"
                                              :preferTypeOnlyAutoImports t
                                              :includeInlayParameterNameHints "all")
                                             :locale "zh-CN")
                                            )
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
      ;; (add-to-list 'eglot-server-programs
      ;;              '(powershell-ts-mode . ("pwsh" "-NoLogo"
      ;;                                   "-NoProfile"
      ;;                                   "-Command"
      ;;                                   "~/PowerShellEditorServices/PowerShellEditorServices/Start-EditorServices.ps1 -Stdio")))
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
                                      (:target "x86_64-pc-windows-gnullvm")
                                      ;; (:target "x86_64-pc-windows-gnu")
                                      :checkOnSave t
                                      :check (:command "clippy")
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
;; (global-set-key (kbd "C-=") 'er/expand-region)
;; (global-set-key (kbd "C-h") 'delete-backward-char)

;; `Todo': Scroll the window where the mouse current is
;; (keymap-global-set "<wheel-left>" #'(lambda ()
;;                                       (interactive)
;;                                       (unless visual-wrap-prefix-mode
;;                                         (scroll-left 1))
;;                                       ))
;; (keymap-global-set "<wheel-right>" #'(lambda ()
;;                                        (interactive)
;;                                        (unless visual-wrap-prefix-mode
;;                                          (scroll-right 1))
;;                                        ))
(keymap-global-set "C-y" #'undo-redo)
(keymap-global-set "C-/" #'comment-line)
(keymap-global-set "C-_" #'comment-line)
(keymap-global-set "M-p" #'scroll-down-line)
(keymap-global-set "M-n" #'scroll-up-line)
(keymap-global-set "M-S-<up>" #'(lambda ()
                                  (interactive)
                                  (setopt duplicate-line-final-position 0)
                                  (duplicate-line)
                                  (setopt duplicate-line-final-position 1)
                                  ))
(keymap-global-set "M-S-<down>" #'(lambda ()
                                    (interactive)
                                    (setopt duplicate-line-final-position 1)
                                    (duplicate-line)
                                    ))
;; (keymap-global-set "C-<tab>" #'tab-line-switch-to-next-tab)
;; (keymap-global-set "C-S-<tab>" #'tab-line-switch-to-prev-tab)
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-ts-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-or-c++-ts-mode))
(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-ts-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-ts-mode))
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-ts-mode))
(add-to-list 'auto-mode-alist '("\\.toml\\'" . toml-ts-mode))
(keymap-global-set "C-c i"
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
    (setopt buffer-offer-save t)
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
(keymap-global-set "C-c n" #'custom-scratch-buffer-create)

(defun hash--beginning-of-line (&optional n)
  "如果当前不在软行首，则跳转到软行首。否则跳转到硬行首。"
  (interactive "^p")
  (or n (setq n 1))
  (if (= (point) (save-excursion (beginning-of-visual-line) (point)))
      (move-beginning-of-line n)
    (beginning-of-visual-line n)))

(defun hash--end-of-line (&optional n)
  "如果当前不在软行尾，则跳转到软行尾。否则跳转到硬行尾。"
  (interactive "^p")
  (or n (setq n 1))
  (if (= (point) (save-excursion (end-of-visual-line) (point)))
      (move-end-of-line n)
    (end-of-visual-line n)))

(keymap-set visual-line-mode-map "C-a" #'hash--beginning-of-line)
(keymap-set visual-line-mode-map "<home>" #'hash--beginning-of-line)
(keymap-set visual-line-mode-map "C-e" #'hash--end-of-line)
(keymap-set visual-line-mode-map "<end>" #'hash--end-of-line)

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

(setopt adaptive-fill-regexp "[ 	]*\\([!|•‣⁃◦]+[ 	]*\\)*\\([*-][ 	]\\[[x ]\\)*")
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
 '(dired-auto-revert-buffer t)
 '(dired-dwim-target t)
 '(dired-movement-style 'bounded)
 '(display-line-numbers-width-start nil)
 '(duplicate-line-final-position 1)
 '(ediff-split-window-function 'split-window-horizontally)
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
 '(magit-ediff-dwim-show-on-hunks t)
 '(marginalia-annotators
   '(marginalia-annotators-heavy marginalia-annotators-light nil) t)
 '(mouse-prefer-closest-glyph t)
 '(org-hide-emphasis-markers nil)
 '(package-archive-priorities '(("gnu" . 99) ("nongnu" . 80) ("melpa" . 70)))
 '(package-quickstart t)
 '(package-selected-packages nil)
 '(pixel-scroll-precision-interpolate-page t)
 '(pixel-scroll-precision-use-momentum t)
 '(read-extended-command-predicate 'command-completion-default-include-p)
 '(require-final-newline t)
 '(ring-bell-function 'ignore)
 '(rust-mode-treesitter-derive t)
 '(scheme-program-name "guile")
 '(scroll-bar-mode nil)
 '(scroll-conservatively 101)
 '(scroll-margin 0)
 '(scroll-preserve-screen-position t)
 '(scroll-step 1)
 '(speedbar-frame-parameters
   '((name . "speedbar") (title . "speedbar") (minibuffer)
     (border-width . 2) (menu-bar-lines . 0) (tool-bar-lines . 0)
     (unsplittable . t) (left-fringe . 10)))
 '(switch-to-buffer-in-dedicated-window 'pop)
 '(switch-to-buffer-obey-display-actions t)
 '(tab-always-indent 'complete)
 '(terminal-here-terminal-command-table
   '((urxvt "urxvt") (gnome-terminal "gnome-terminal")
     (gnome-console "kgx") (alacritty "alacritty") (xst "xst")
     (st . terminal-here--find-and-run-st) (konsole "konsole")
     (qterminal "qterminal") (xterm "xterm") (sakura "sakura")
     (xfce4-terminal "xfce4-terminal") (terminator "terminator")
     (terminology "terminology") (tilix "tilix") (kitty "kitty")
     (foot "foot") (ghostty "ghostty")
     (x-terminal-emulator "x-terminal-emulator")
     (terminal-app "Terminal.app") (iterm2 "iTerm.app")
     (cmd "cmd.exe" "/C" "start" "cmd.exe")
     (pwsh "cmd.exe" "/C" "start" "pwsh.exe")))
 '(terminal-here-windows-terminal-command 'pwsh)
 '(treesit-auto-langs
   '(c cpp bash css html python rust javascript typescript json css
       dockerfile yaml sql toml))
 '(treesit-font-lock-level 4)
 '(vertico-cycle t)
 '(visual-wrap-extra-indent 2)
 '(whitespace-style
   '(face trailing tabs spaces indentation space-after-tab
          space-before-tab tab-mark))
 '(word-wrap-by-category t)
 '(xref-show-definitions-function 'xref-show-definitions-completing-read t))

(put 'scroll-left 'disabled nil)

