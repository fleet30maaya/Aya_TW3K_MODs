# 修改战斗中单位头顶信息 UI

这个修改的目的是在战斗中让部队顶上的 UI 带有传统的战旗。我并不想做 3D 的旗帜，只想用 2D 来做。

理想情况是以旗帜的破损程度显示 HP，用旗帜花纹的颜色显示体力等级。如果玩家选择显示详细信息，那么额外显示血条。

## 1. 对这个 UI 的简单分析

```text
root
 │
 ├─┬─ unit_id
 │ │
 │ ├─── mouseover_bounds  鼠标判定区域
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

## 2. 修改

### 加入旗帜

在 ````mouseover_bounds```` 和 ````bobblehead_parent```` 之间加入旗帜的显示。

最初的方案是响应 ContextStateSetter 更换图片，同时响应 ContextColourSetter 显示团队色。但这个尝试失败了。怀疑是切换 state 时一定会改变颜色，覆盖了 AllianceColour 的设定。

通过各种测试，替代方案是：

- 准备 5 个结点（因为我把 HP 分为 5 段），分别使用不同的图片，并设置团队色
- 根据 HP 比例，响应 ContextVisibilitySetter 决定是否显示

进一步，准备将同一个 HP 区间的旗帜本体、内部装饰图片、花纹等都放进一个 flag_node 内。因为内部装饰图片有时要配合旗帜的破损，所以也统一显示和隐藏。接下来将测试旗帜是否能剪裁内部的内容。如果可以剪裁则容易很多。
