extends BaseButtonSetting

func _after_init():
	if BaseSetting.data.is_full_screen:
		text = "全屏：开"
	else:
		text = "全屏：关"

#切换是否全屏
func _on_button_up():
	BaseSetting.set_full_screen(!BaseSetting.data.is_full_screen)
	if BaseSetting.data.is_full_screen:
		text = "全屏：开"
	else:
		text = "全屏：关"
