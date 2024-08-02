extends Node2D

@onready var button = $Button
@onready var boom = $Button/Boom
@onready var timer = $Button/Timer

var start_position : Vector2
var end_position : Vector2
var start_modulate : Color
var end_modulate : Color
var bubble_word_dictionary = {
	1: "今天天气怎么样？",
	2: "你的心情如何？",
	3: "你最喜欢的颜色是？",
	4: "你的爱好是？",
	5: "fucku",
	6: "你晚上吃什么？"
}
var bubble_theme_dictionary = {
	1: "BubbleButton1",
	2: "BubbleButton2",
	3: "BubbleButton3",
}

func _button_appear():
	start_position = button.position
	end_position = start_position-Vector2(0,600)
	create_tween().tween_property(button,"position",end_position,randf_range(0.5,2))
	start_modulate = Color(1,1,1,1)
	create_tween().tween_property(button,"modulate",start_modulate,1.5)
	button.set_text(bubble_word_dictionary[randi_range(1,6)])
	button.set_theme_type_variation(bubble_theme_dictionary[randi_range(1,3)])

func _on_button_pressed():
	button.set_disabled(true)
	end_modulate = Color(1,1,1,0)
	#逐渐透明
	create_tween().tween_property(button,"modulate",end_modulate,1)
	boom.set_visible(true)
	await get_tree().create_timer(1).timeout
	button.queue_free()

func _on_timer_timeout():
	var disappear_position = button.position-Vector2(0,500)
	#飞出屏幕
	create_tween().tween_property(button,"position",disappear_position,2)
	await get_tree().create_timer(2).timeout
	button.queue_free()
