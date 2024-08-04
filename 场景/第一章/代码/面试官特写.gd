extends GameInit

var bubble_scene = preload("res://场景/第一章/场景/气泡.tscn")
var bubble_init_array : Array
@onready var bubble_end_locations = [$"最终位置/气泡位置1", $"最终位置/气泡位置2", $"最终位置/气泡位置3"]
@onready var bubble_start_locations = [$"初始位置/气泡位置1", $"初始位置/气泡位置2", $"初始位置/气泡位置3"]

func _init_game():
	await get_tree().create_timer(BaseSetting.move_time).timeout
	for i in range(3):
		add_child(bubble_init_array[i])
		bubble_init_array[i]._bubble_appear(bubble_start_locations[i].global_position,bubble_end_locations[i].global_position)
		await get_tree().create_timer(2).timeout
		
func _ready():
	for i in range(3):
		var bubble_init = bubble_scene.instantiate()
		bubble_init_array.push_front(bubble_init)
