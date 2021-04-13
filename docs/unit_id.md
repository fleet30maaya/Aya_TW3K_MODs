# 修改战斗中单位头顶信息 UI

## 对这个 UI 的简单分析

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