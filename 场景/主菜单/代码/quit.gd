extends BaseButtonStart


#如果按压中就退出
func _on_button_up():
	if is_press:
		get_tree().quit()
	is_press = false
