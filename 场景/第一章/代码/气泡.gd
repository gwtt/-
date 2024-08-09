extends Node2D

@onready var bubble = $"气泡"
@onready var boom = $"气泡/气泡爆炸"
@onready var splash = $"气泡/气泡破裂"

func _on_气泡_pressed():
	bubble.set_material(null)
	var tween_bubble = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween_bubble.tween_property(bubble,"self_modulate",Color(1,1,1,0),0.3)
	splash.play()
	var tween_boom = create_tween()
	tween_boom.tween_property(boom,"modulate",Color(1,1,1,1),0.3)
	tween_boom.tween_property(boom,"modulate",Color(1,1,1,0),0.3)
	tween_boom.tween_interval(0.3)
	await get_tree().create_timer(0.3).timeout
	self.queue_free()
	var parent = get_node("..")
	parent.count += 1
	if(parent.count == 3):
		GlobalGameManager.emit_complete_game()

func _bubble_appear(bubble_theme,end_position):
	bubble.set_theme_type_variation(bubble_theme)
	create_tween().tween_property(self,"global_position",end_position,0.5)
	
func _bubble_twist(speed,intensity):
	bubble.material.set_shader_parameter("speed", speed)
	bubble.material.set_shader_parameter("intensity", intensity)

