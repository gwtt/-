extends BaseButtonClick

func _ready():
	super()
	GlobalGameManager.transition_button.connect(change_node)

func on_button_up():
	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"position",origin_position,0.2)
	tween.tween_property(self,"modulate",Color(1,1,1,0),0.2)
	await get_tree().create_timer(0.2).timeout
	self.visible = false
	GlobalGameManager.emit_complete_game()


func change_node():
	self.visible = true
	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"position",origin_position,0.2)
	tween.tween_property(self,"modulate",Color(1,1,1,1),0.2)
