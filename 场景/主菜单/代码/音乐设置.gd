extends BaseButtonSetting


func _on_button_up():
	BaseSetting.music = BaseSetting.music + 1
	text="音乐："+str(BaseSetting.music)
