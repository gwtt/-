extends BaseButtonSetting

func _after_init():
	text="音效："+str(BaseSetting.data.sound_scape)

func _on_button_up():
	BaseSetting.data.sound_scape = BaseSetting.data.sound_scape + 1
	text="音效："+str(BaseSetting.data.sound_scape)
