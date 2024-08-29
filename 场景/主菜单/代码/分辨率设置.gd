extends BaseButtonSetting

func _after_init():
	var temp:Vector2i = BaseSetting.get_screen_resolution()
	text = "画面:"+str(temp.x)+"X"+str(temp.y)
	
#切换分辨率
func _on_button_up():
	var temp:Vector2i = BaseSetting.set_screen_resolution(BaseSetting.data.screen_resolution_index + 1)
	text = "画面:"+str(temp.x)+"X"+str(temp.y)
