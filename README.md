# Aya_TW3K_MODs

这个仓库是全战三国自制 MOD 合集，主要目的是方便管理版本。

大体上，可以把全部文件打包做成 MOD 。但我也会把每个 MOD 涉及的文件单独列出来以方便独立打包。

## 用代码生成界面

相关文件：

```text
 └─┬─ script
   └─┬─ campaign
     └─┬─ mod
       ├─┬─ components
       │ ├─── UI_Mod_UIEntry.lua
       │ ├─── UI_Mod_UIPanel.lua
       │ └─── UI_Mod.lua
       ├─┬─ lib
       │ ├─── classic.lua
       │ └─── UI_Mod_lib_ui.lua
       └─── ui_mod.lua
```

本部分代码使用了 [classic](https://github.com/rxi/classic) 作为 OO 方案。

CA 奇怪地修改了自己的 UI 脚本方法，以前正常运行的脚本现在报错。目前的版本修复了可见的错误，基本可以运行。
