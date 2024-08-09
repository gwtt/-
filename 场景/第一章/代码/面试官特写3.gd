extends GameInit

@onready var bubble_1 = $"气泡1"
@onready var bubble_2 = $"气泡2"
@onready var bubble_3 = $"气泡3"
@onready var bubble_end_location_1 = $"气泡最终位置1"
@onready var bubble_end_location_2 = $"气泡最终位置2"
@onready var bubble_end_location_3 = $"气泡最终位置3"
var count = 0

func _init_game():
	bubble_1._bubble_twist(1.5,0.05)
	bubble_2._bubble_twist(1.5,0.05)
	bubble_3._bubble_twist(1.5,0.05)
	await get_tree().create_timer(BaseSetting.move_time).timeout
	bubble_1._bubble_appear("SocialBubble",bubble_end_location_1.global_position)
	await get_tree().create_timer(0.2).timeout
	bubble_2._bubble_appear("TimeBubble",bubble_end_location_2.global_position)
	await get_tree().create_timer(0.2).timeout
	bubble_3._bubble_appear("HolidayBubble",bubble_end_location_3.global_position)
