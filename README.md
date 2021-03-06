# Aya_TW3K_MODs

这个仓库是全战三国自制 MOD 合集，主要目的是方便管理版本。

大体上，可以把全部文件打包做成 MOD 。但我也会把每个 MOD 涉及的文件单独列出来以方便独立打包。

每个具体修改的内容可以到 ````docs```` 目录下查看对应的文档。

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

## 单位兵牌

相关文件：

```text
 └─┬─ ui
   ├─┬─ battle ui
   │ └─── unit_card.twui.xml  战术面兵种兵牌
   ├─┬─ campaign ui
   │ ├─── unit_card_hero.twui.xml  战略面人物兵牌
   │ ├─── unit_card.twui.xml  战略面兵种兵牌
   │ └─── units_panel.twui.xml  招募面板
   ├─┬─ loading_ui
   │ ├─── battle.twui.xml  进入战斗界面
   │ └─── postbattle.twui.xml  结束战斗界面
   ├─┬─ skins
   │ └─┬─ default
   │   ├─── stars_ui_card_rank_1.png
   │   ├─── stars_ui_card_rank_2.png
   │   ├─── stars_ui_card_rank_3.png
   │   ├─── stars_ui_card_rank_4.png
   │   ├─── stars_ui_card_rank_5.png
   │   ├─── stars_ui_card_rank_6.png
   │   ├─── stars_ui_card_rank_7.png
   │   ├─── stars_ui_card_rank_8.png
   │   ├─── stars_ui_card_rank_9.png
   │   └─── stars_ui_card_rank_10.png
   └─┬─ templates
     └─── custom_battle_army_entry.twui.xml  战前准备界面
```

## 【工事中】修改战斗时的部队信息显示

相关文件：

```text
 └─┬─ ui
   └─┬─ battle ui
     └─── unit_id.twui.xml
```
