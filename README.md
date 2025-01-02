# .emacs.d

自用的基于 [Crafted Emacs](https://github.com/SystemCrafters/crafted-emacs/) 的 Emacs 配置。

## 配置原则

Visual Studio Code 是我的主力编辑器，足以应付大部分前端、写作和 Rust 工作，但我仍需一快速启动的终端编辑器，来临时修改 shell profile 等小文件，以及节约宝贵的内存。为此我折腾过无数次。Sublime、Zed 都不太合我意。Emacs 经过优化，启动速度能攀比 OneNote，初始化时间约0.6s（图形）0.13s（终端），功能齐全，足够好玩且满意。

总体原则如下：

* 支持现代功能（Eglot，Tree-sitter，内联补全，etc）；
* 内置功能优先（Dired，iBuffer over treemacs，minibuffer over modeline）；
* 遵守 Unix 终端和现代图形界面的键位约定（[Unix](https://en.wikipedia.org/wiki/Control_key)，[Cut, copy, and paste](https://en.wikipedia.org/wiki/Cut,_copy,_and_paste)），尊重 VSCode 里养成的肌肉记忆和审美；
* 兼容 Windows 和 Linux，同时支持从 Windows Shell 和 MSYS2 bash 打开；
* 冷启动要快。

（顺便吐槽，XCV 是苹果发明的，和 [CUA](https://en.wikipedia.org/wiki/IBM_Common_User_Access) 完全不沾边，不知道为什么 Emacs 要给苹果模式起个 IBM 名字）

本人使用 Windows，Emacs 选取 MSYS2 UCRT 译本（给 `PKGBUILD` 和 `src/comp.c` 加了个小补丁，是 Gentoo 用户最喜欢的优化和强化参数）。大部分软件我偏爱 Clang64 译本，Emacs 除外，因为 native-comp 依赖 libgccjit。MSYS2 Shell 和 Windows Shell 对 `$HOME` 的规定有所不同，建议为 `.emacs.d` 创建 Junction 链接。其余文件随意。

```batch
mklink /J C:\msys64\home\hash\.emacs.d C:\Users\hash\AppData\Roaming\.emacs.d
```

我很高兴 Emacs 里能配置我最喜欢的功能：`visual-wrap-prefix-mode`。更高兴 Emacs 30 预装了此包。

## pdump

这能大幅度提高启动速度。市面上最好的文档是 [Painless Transition to Portable Dumper](https://archive.casouri.cc/note/2020/painless-transition-to-portable-dumper/)，我的 `early-init.el` 和 `dump.el` 都从那里抄来。

提示：

* 如果希望 dump elpa 包，则应先从 `eln-cache` 中删除。不 dump 的包和内置包不受影响，可以正常加载 eln。
* dump 主题对启动速度的影响最明显。
* 注意测试同时兼容 dump 和普通加载的 Emacs。
* 在 `early-init.el` 里修改 GC 参数，禁止启动期间搜集垃圾，对启动时间效果同样拔群。

## 速查

```pwsh
# Generate portable dump
C:\msys64\ucrt64\bin\emacs.exe -q --batch -l C:\Users\hash\AppData\Roaming\.emacs.d\dump.el

# Use portable dump
C:\msys64\ucrt64\bin\emacs.exe --dump-file "${env:APPDATA}/.emacs.d/emacs.pdmp"

# Part of my profile.ps1
function emacs {
    if ($args -contains "-nw") {
        C:\msys64\ucrt64\bin\emacs.exe --dump-file "${env:APPDATA}/.emacs.d/emacs.pdmp" $args;
    }
    else {
        C:\msys64\ucrt64\bin\runemacs.exe --dump-file "${env:APPDATA}/.emacs.d/emacs.pdmp" $args;
    }
}
```

.ink 任务栏图标（设置运行方式“最小化”）：

路径 %APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar

```batch
C:\Windows\System32\cmd.exe /c "SET LANG=zh_CN.UTF-8&& SET Path=%path%;C:\msys64\ucrt64\bin;C:\msys64\usr\bin&& START ^"^" ^"C:\msys64\ucrt64\bin\runemacs.exe^" --dump-file=%APPDATA%/.emacs.d/emacs.pdmp"
```



## 改进空间

- [x] Wait for Emacs 30: `visual-wrap-prefix-mode`; ts-mode 继承；`tab-line-mode`（划掉，不喜欢）
- [x] 懒加载 eglot & tree-sitter（别的懒得管了，我自己写的 dll 加载都比他慢）；
- [x] ~~使 vtsls 和 pyright 正常工作~~ 已经用别的部分代替；
- [ ] ~~使 client/deamon 模式正常工作~~ 目前冷启动足够快。
- [ ] Try GUD with LLDB；

## 同步上游

本仓库严格基于 Crafted Emacs 的最新分支。顺便一提，它的默认设置延迟加载做得很差，官方认为这是教学项目不应该用太多宏所以[拒绝使用](https://github.com/SystemCrafters/crafted-emacs/issues/260) `use-package`——那是我设置延迟启动最有效的办法。于是乎我用 `use-package` 把许多包的加载重写了一遍。

未来我自己添加的所有包都会迁移至用 `use-package` 加载。

备忘：[变基方法](https://gist.github.com/ravibhure/a7e0918ff4937c9ea1c456698dcd58aa)
