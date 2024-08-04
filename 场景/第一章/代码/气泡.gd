extends Node2D

@onready var bubble = $"气泡"
@onready var boom = $"气泡/气泡爆炸"

var start_position : Vector2
var end_position : Vector2
var start_modulate : Color
var end_modulate : Color
var bubble_theme_dictionary = {
	1: "SalaryBubble",
	2: "TimeBubble",
	3: "HolidayBubble",
	4: "BagBubble",
	5: "SocialBubble",
}
	
func _on_气泡_pressed():
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
	GlobalGameManager.emit_complete_game()

func _bubble_appear(start_position,end_position):
	bubble.set_theme_type_variation(bubble_theme_dictionary[randi_range(1,5)])
	bubble.set_global_position(start_position)
	create_tween().tween_property(bubble,"global_position",end_position,randf_range(0.5,2))
