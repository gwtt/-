extends BaseButtonSetting

func _after_init():
	text="音乐："+str(BaseSetting.data.music)

func _on_button_up():
	BaseSetting.data.music = BaseSetting.data.music + 1
	text="音乐："+str(BaseSetting.data.music)
