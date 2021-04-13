# 修改兵牌

这个修改的目的是在兵牌中以算筹显示等级，代替目前的数字显示。这还原了发售前宣传的 UI 风格，某种程度是一种复古（？）。

另一方面这个修改非常简单，可以练手。

## 1. 对这个 UI 的简单分析

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

## 2. 修改

Rank 原先作为 text label 使用：

```xml
<callback_with_context
    callback_id="ContextTextLabel"
    context_object_id="CcoUnitDetails"
    context_function_id="ExperienceLevel + 1"/>
```

> 有趣的一点是兵种的等级实际是 0-9 而非 1-10。然而人物的等级确实是 1-10。这个区别可能是因为人物涉及技能点吧。

我的修改思路是 rank 不再作为 text 使用，而是根据等级的不同显示不同的图片。

### 首先给这个节点加入会用到的图片

```xml
<componentimages>
	<component_image
		this="3AB07F03-09DD-4495-ACEA0A136522E266"
		uniqueguid="3AB07F03-09DD-4495-ACEA0A136522E266"
		imagepath="ui/skins/default/stars_ui_card_rank_1.png"
		width="18"
		height="18"
		canuse1bitalpha="false"/>
	<component_image
		this="3AB07F03-09DD-4495-ACEA0A136522E267"
		uniqueguid="3AB07F03-09DD-4495-ACEA0A136522E267"
		imagepath="ui/skins/default/stars_ui_card_rank_2.png"
		width="18"
		height="18"
		canuse1bitalpha="false"/>
	...
	<component_image
		this="3AB07F03-09DD-4495-ACEA0A136522E275"
		uniqueguid="3AB07F03-09DD-4495-ACEA0A136522E275"
		imagepath="ui/skins/default/stars_ui_card_rank_10.png"
		width="18"
		height="18"
		canuse1bitalpha="false"/>
```

众所周知，uid 是稀疏而随机的，所以只要我手动顺着往下排就不会重复（误）。

### 然后把控件改为响应 ContextStateSetter

```xml
<callbackwithcontextlist>
	<callback_with_context
		callback_id="ContextStateSetter"
		context_object_id="CcoCampaignUnit"
		context_function_id="ExperienceLevel">
		<child_m_user_properties>
			<property
				name="event0"
				value="UnitExperienceGain"/>
		</child_m_user_properties>
	</callback_with_context>
	<callback_with_context
		callback_id="ContextStateSetter"
		context_object_id="CcoUnitDetails"
		context_function_id="ExperienceLevel"/>
</callbackwithcontextlist>
```

这里我也不再给等级 +1 了，看着更舒服些。

### 每个等级会对应一个 state，添加进去

```xml
<states>
	<_0
		this="B9B52236-15A1-4B7D-85E206530E571608"
		name="0"
		...
		uniqueguid="B9B52236-15A1-4B7D-85E206530E571608">
		<imagemetrics>
			<image
				componentimage="3AB07F03-09DD-4495-ACEA0A136522E266"
				.../>
		</imagemetrics>
	</_0>
	<_1
		this="B9B52236-15A1-4B7D-85E206530E571609"
		name="1"
		...
		uniqueguid="B9B52236-15A1-4B7D-85E206530E571609">
		<imagemetrics>
			<image
				componentimage="3AB07F03-09DD-4495-ACEA0A136522E267"
				.../>
		</imagemetrics>
	</_1>
	...
	<_9
		this="B9B52236-15A1-4B7D-85E206530E571617"
		name="9"
		...
		uniqueguid="B9B52236-15A1-4B7D-85E206530E571617">
		<imagemetrics>
			<image
				componentimage="3AB07F03-09DD-4495-ACEA0A136522E275"
				.../>
		</imagemetrics>
	</_9>
</states>
```

每个 state 的 xml 名字并不重要，重要的是 name 属性定义的名字。Callback 会去找这个名字。

### 一些细节

- 坐标需要反复调
- 游戏并没有 10 级的算筹图片，所以用虎符图片表示 10 级，作为可以改名的精锐部队这说得通
- 干脆修改了原有的算筹图片，让 6 级以后的辨识度更高了
- rank 的默认状态设置为 10 级而不是 1 级，这么做是有理由的：一些 mod 会修改兵种/人物的等级上限超过 10 级，这时候 callback 找不到对应的 state 就会显示为默认的 10 级图片

## 3. 其他界面修改

- campaign ui 里有兵种和人物的兵牌
- battle ui 只需要修改兵种兵牌，人物的并不包括等级显示，不用修改
