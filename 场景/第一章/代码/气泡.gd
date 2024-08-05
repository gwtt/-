extends Node2D

@onready var bubble = $"气泡"
@onready var boom = $"气泡/气泡爆炸"
	
func _on_气泡_pressed():
	bubble.set_material(null)
	var tween_bubble = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween_bubble.tween_property(bubble,"self_modulate",Color(1,1,1,0),0.3)
	#tween.tween_interval(0.2)
	await get_tree().create_timer(0.25).timeout
	var tween_boom = create_tween()
	tween_boom.tween_property(boom,"modulate",Color(1,1,1,1),0.5)
	tween_boom.tween_property(boom,"modulate",Color(1,1,1,0),0.5)
	tween_boom.tween_interval(0.5)
	await get_tree().create_timer(1.7).timeout
	bubble.queue_free()
	var parent = get_node("..")
	parent.count+=1
	if(parent.count == 3):
		GlobalGameManager.emit_complete_game()

func _bubble_appear(bubble_theme,end_position):
	bubble.set_theme_type_variation(bubble_theme)
	create_tween().tween_property(bubble,"global_position",end_position,randf_range(0.5,2))
	
func _bubble_twist(speed,intensity):
	bubble.material.set_shader_parameter("speed", speed)
	bubble.material.set_shader_parameter("intensity", intensity)

