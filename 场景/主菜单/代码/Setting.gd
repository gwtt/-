extends BaseButtonStart
@onready var 第二切割: VBoxContainer = $"../../../../设置界面/HBoxContainer/MarginContainer/第二切割"

func _on_button_up():
	super._on_button_up()
	for child in 第二切割.get_children():
		child._after_init()
		
