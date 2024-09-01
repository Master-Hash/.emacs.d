# .emacs.d

自用的基于 [Crafted Emacs](https://github.com/SystemCrafters/crafted-emacs/) 的 Emacs 配置。

## 配置原则

Visual Studio Code 是我的主力编辑器，足以应付大部分前端、写作和 Rust 工作，但我仍需一快速启动的终端编辑器，来临时修改 shell profile 等小文件，以及节约宝贵的内存。为此我折腾过无数次。Sublime、Zed 都不太合我意，Emacs 也许能担此大任。

总体原则如下：

* 内置功能优先；
* 优先使用 tree-sitter 和 lsp，次而选择传统的主要模式；
* 遵守 Unix 终端和 Windows 图形的[键位约定](https://en.wikipedia.org/wiki/Control_key)，尊重 VSCode 里养成的肌肉记忆和审美；

本人使用 Windows，Emacs 选取 MSYS2 UCRT 译本。大部分软件我偏爱 Clang64 译本，Emacs 除外，因为 native-comp 依赖 libgccjit。MSYS2 Shell 和 Windows Shell 对 `$HOME` 的规定有所不同，我仅在 Windows Shell 下使用，因此本仓库应该位于 `%APPDATA%` 目录下。

我很高兴 Emacs 里能配置我最喜欢的功能：`adaptive-wrap-prefix-mode`。因为内置功能 `wrap-prefix` 不会在已有缩进的基础上额外缩进，我用了 `adaptive-wrap` 包。（隔壁 Vim 似乎也支持）

## 改进空间

* 懒加载模块（例如首屏不显示的 imenu-list）；
* 使 vtsls 和 pyright 正常工作；

## 同步上游

本仓库严格基于 Crafted Emacs 的最新分支。

备忘：[变基方法](https://gist.github.com/ravibhure/a7e0918ff4937c9ea1c456698dcd58aa)
