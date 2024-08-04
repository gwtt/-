extends Node2D

@onready var button = $Button
@onready var boom = $Button/Boom
@onready var timer = $Button/Timer

var StartPos : Vector2
var EndPos : Vector2
var StartMod : Color
var EndMod : Color
var bubble_word_dictionary = {
	1: "今天天气怎么样？",
	2: "你的心情如何？",
	3: "你最喜欢的颜色是？",
	4: "你的爱好是？",
	5: "fucku",
	6: "你晚上吃什么？"
}
var bubble_theme_dictionary = {
	1: "BubbleButton",
	2: "BubbleButton1",
	3: "BubbleButton2",
}

func _button_appear():
	StartPos = button.position
	EndPos = StartPos-Vector2(0,600)
	create_tween().tween_property(button,"position",EndPos,randf_range(0.5,2))
	StartMod = Color(1,1,1,1)
	create_tween().tween_property(button,"modulate",StartMod,1.5)
	button.set_text(bubble_word_dictionary[randi_range(1,6)])
	button.set_theme_type_variation(bubble_theme_dictionary[randi_range(1,3)])

func _on_button_pressed():
	button.set_disabled(true)
	EndMod = Color(1,1,1,0)
	var DisPos = button.position+Vector2(0,500)
	#逐渐透明
	create_tween().tween_property(button,"modulate",EndMod,1)
	boom.set_visible(true)
	await get_tree().create_timer(1).timeout
	button.queue_free()
	var parent = get_node("..")
	parent._progress_change()

func _on_timer_timeout():
	var DisPos = button.position-Vector2(0,500)
	#飞出屏幕
	create_tween().tween_property(button,"position",DisPos,2)
	await get_tree().create_timer(2).timeout
	button.queue_free()
