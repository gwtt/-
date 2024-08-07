extends BaseButtonClick
@onready var panel = $"../Panel"


func on_button_up():
	super()
	panel.init()
