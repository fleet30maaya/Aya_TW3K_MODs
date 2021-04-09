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

## 【工事中】修改战斗时的部队信息显示

相关文件：

```text
 └─┬─ ui
   └─┬─ battle ui
     └─── unit_id.twui.xml
```

对这个 UI 的简单分析：

```text
root
 │
 ├─┬─ unit_id
 │ │
 │ ├─── mouseover_bounds
 │ │
 │ ├─┬─ bobblehead_parent  头像
 │ │ └─┬─ bobblehead_swirl_frame
 │ │   └─┬─ bobblehead_base
 │ │     ├─── unit_portrait
 │ │     └─┬─ character_portrait
 │ │       └─── icon_portrait_highlight
 │ │
 │ ├─┬─ details_parent  详细信息
 │ │ ├─┬─ radial_list_left
 │ │ │ ├─── icon_health  血量，响应 ContextStateSetter.CcoBattleUnit.HealthPercent，阈值 0.4、0.7
 │ │ │ └─── icon_status  一些 Important（？） 状态
 │ │ └─┬─ radial_list_right
 │ │   └─── icon_fatigue  疲劳，响应 ContextStateSetter.CcoBattleUnit.FatigueState， 0-5 共 6 个区间/状态
 │ │
 │ ├─┬─ cat_docker  谁知道什么是 cat？
 │ │ └─┬─ cat_frame
 │ │   │
 │ │   ├─┬─ mask_parent  血量的遮罩，button_circle_ability_backplate 圆形的图
 │ │   │ └─── health_fill  血量，响应 ContextFillBar.CcoBattleUnit.HealthPercent，颜色 ContextColourSetter.CcoBattleUnit.AllianceColour， 图是简单的 1x1_white
 │ │   │
 │ │   ├─── unit_icon  单位图标，叠了很多不同状态的图
 │ │   ├─── highlight_frame
 │ │   ├─┬─ icon_ammo  弹药，有阈值切换颜色，有动画，OnEnterState_2 会触发 fade_in
 │ │   │ └─┬─ ammo_bar_parent  弹药背景，响应 ContextVisibilitySetter.CcoBattleUnit.PrimaryAmmoPercent
 │ │   │   └─── stat_fill_bar  弹药，ContextFillBar.CcoBattleUnit.PrimaryAmmoPercent 决定填充，ContextStateSetterConditional.CcoBattleUnit 决定颜色
 │ │   │
 │ │   ├─── icon_vehicle  响应 ContextVisibilitySetter.CcoBattleUnit.VehicleContext
 │ │   ├─── flashing_overlay
 │ │   ├─┬─ awaiting_order_parent
 │ │   │ └─── icon_awaiting_order
 │ │   │
 │ │   ├─── icon_retinue  响应 ContextVisibilitySetter.CcoBattleUnit.ShouldShowRetinueIcon
 │ │   ├─── icon_high_tier
 │ │   ├─── icon_cat_highlight
 │ │   ├─┬─ awaiting_extraction_parent
 │ │   │ └─── icon_awaiting_extraction
 │ │   │
 │ │   └─── not_selected
 │ │
 │ ├─── icon_shared
 │ │
 │ ├─┬─ engine_list
 │ │ └─┬─ template_entry
 │ │   └─┬─ reload_indicator
 │ │     ├─┬─ clip_right
 │ │     │ └─── ring_right
 │ │     └─┬─ clip_left
 │ │       └─── ring_left
 │ │
 │ ├─┬─ speech_bubble
 │ │ ├─── speech_highlight_frame
 │ │ └─┬─ speech_bubble_icon
 │ │   └─── speech_waves_anim
 │ │
 │ ├─── icon_threat
 │ ├─── guerrilla
 │ ├─── icon_effect
 │ │
 │ ├─┬─ duel_ability_anim
 │ │ ├─┬─ button_ability1
 │ │ │ ├─── icon_active
 │ │ │ └─── frame_melee
 │ │ └─── circle_glow
 │ │
 │ └─── ability_anim_holder
 │
 └─── unused_components
```

目前的修改内容是在 UI 后面加了一个图，然后把部队血条变成了横向矩形条。

## 【工事中】单位兵牌

相关文件：

```text
 └─┬─ ui
   └─┬─ campaign ui
     └─── unit_card.twui.xml
```

对这个 UI 的简单分析：

```text
root
 │
 └─┬─ unit_card
   │
   ├─── gradient
   ├─┬─ convalescing
   │ └─── convalescing_timer
   ├─── replenish
   ├─┬─ individual_kills
   │ └─── label_turns_to_muster
   ├─┬─ element_icon
   │ └─── rank    < 关注这个
   │
   ├─┬─ experience_holder
   │ ├─── experience
   │ └─┬─ post_battle_rank
   │   ├─── old_rank
   │   └─── new_rank
   ├─── label_num_entities
   ├─── label_num_entities_postbattle
   ├─┬─ health_bar_parent
   │ ├─── replenishment_bar
   │ └─┬─ stat_fill_bar
   │   └─┬─ attrition_bar_parent
   │     └─── attrition_bar
   ├─┬─ health_bar_parent_postbattle
   │ └─── stat_fill_bar_postbattle
   ├─┬─ refund_overlay
   │ └─── refund_label
   └─── turns_to_muster
```

把 rank 改成了 rank_image。名字不重要，重要的是控件类型。原先是 TextLabel，现在改为响应 ContextStateSetter，按照等级的不同改变图片。由于 fast.pack 里只提供了 1-9 级的图片，10 级使用 5 级的图片并以金色显示。
