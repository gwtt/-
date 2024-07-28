extends Node2D

@onready var character = $CharacterBody2D/AnimatedSprite2D
@onready var check_button = $CheckButton
@onready var progressbar = $TextureProgressBar

var bubble_scene = preload("res://游戏互动场景/对话气泡/场景/bubble.tscn")
var bubble_init_array : Array
var isAlive = true

func _ready():
	for i in range(30):
		var bubble_init = bubble_scene.instantiate()
		bubble_init_array.push_front(bubble_init)

func _on_check_button_pressed():
	check_button.set_disabled(true)
	for i in range(30):
		add_child(bubble_init_array[i])
		bubble_init_array[i].set_position(Vector2(randi_range(-700,700),randi_range(200,400)))
		bubble_init_array[i]._button_appear()
		await get_tree().create_timer(2).timeout

func _progress_change():
	create_tween().tween_property(progressbar,"value",progressbar.value+0.2,0.5)
	if (progressbar.value == 1 and isAlive):
		character.play("dead")
		isAlive = false
