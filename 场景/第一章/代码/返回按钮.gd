extends BaseButtonMovetoNotClick
@onready var panel = $".."

func _on_button_up():
	if is_press:
		panel.shut()
	super()
