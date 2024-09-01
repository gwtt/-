extends Node2D
const menu_path = "res://场景/主菜单/场景/开始界面.tscn"
@export var next_scene:PackedScene
@onready var panel_container = $CanvasLayer/PanelContainer
@export var wait_time:float = 1

func _ready():
	GlobalGameManager.back_to_menu.connect(back_to_menu)
	GlobalGameManager.turn_to_next.connect(turn_to_next)
	ResourceLoader.load_threaded_request(menu_path,"",true)
	panel_container.visible=true
	await get_tree().create_timer(wait_time).timeout
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(panel_container,"modulate",Color(1,1,1,0),wait_time)
	await get_tree().create_timer(wait_time).timeout
	panel_container.visible=false
	
func back_to_menu():
	panel_container.visible=true
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(panel_container,"modulate",Color(1,1,1,1),wait_time)
	await get_tree().create_timer(wait_time).timeout
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(menu_path))

func turn_to_next():
	panel_container.visible=true
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(panel_container,"modulate",Color(1,1,1,1),wait_time)
	await get_tree().create_timer(wait_time).timeout
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)
