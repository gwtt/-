extends BaseButtonSetting


func _on_button_up():
	BaseSetting.sound_scape = BaseSetting.sound_scape + 1
	text="音效："+str(BaseSetting.sound_scape)
