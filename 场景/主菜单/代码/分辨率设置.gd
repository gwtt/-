extends BaseButtonSetting


#切换分辨率
func _on_button_up():
	var temp:Vector2i = BaseSetting.set_screen_resolution(BaseSetting.screen_resolution_index + 1)
	text = "画面:"+str(temp.x)+"X"+str(temp.y)
