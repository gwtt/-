extends GameInit

@onready var post: Label = $"岗位"
@onready var salary: Label = $"工资"
@onready var graduation: Label = $"学历"
@onready var experience: Label = $"工作经验"
@onready var holiday: Label = $"假期"
@onready var left: TextureButton = $"左边按钮"
@onready var right: TextureButton = $"右边按钮"
@onready var click_sound: AudioStreamPlayer2D = $"点击声音"

var move_time:float = 0.5

var post_dictionary = {
	1: "■■■",
	2: "■■",
}
var salary_dictionary = {
	1: "3-6千",
	2: "6-8千",
	3: "7千-1万",
	4: "1-1.5万",
	5: "1.5-2万",
	6: "2万+",
}
var graduation_dictionary = {
	1: "大专",
	2: "本科",
	3: "硕士",
	4: "博士",
}
var experience_dictionary = {
	1: "1年以上",
	2: "3年以上",
	3: "5年以上",
	4: "6月以上",
}
var holiday_dictionary = {
	1: "小周单休",
	2: "单休",
	3: "双休",
	4: "大周双休",
}

func random_content():
	post.set_text(post_dictionary[randi_range(1,2)])
	salary.set_text(salary_dictionary[randi_range(1,6)])
	graduation.set_text(graduation_dictionary[randi_range(1,4)])
	experience.set_text(experience_dictionary[randi_range(1,4)])
	holiday.set_text(holiday_dictionary[randi_range(1,4)])

func _on_左边按钮_pressed() -> void:
	right.set_disabled(true)
	click_sound.play()
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	var parent = get_node("../../")
	tween.tween_property(self,"global_position",parent.disappear_post.global_position,move_time)
	await get_tree().create_timer(move_time).timeout
	self.queue_free()
	parent.count += 1
	if parent.count == 5:
		GlobalGameManager.emit_complete_game()
	parent.create_node()
	
func _on_右边按钮_pressed() -> void:
	left.set_disabled(true)
	click_sound.play()
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	var parent = get_node("../../")
	tween.tween_property(self,"global_position",parent.disappear_post.global_position,move_time)
	await get_tree().create_timer(move_time).timeout
	self.queue_free()
	parent.count += 1
	print(parent.count)
	if parent.count == 5:
		GlobalGameManager.emit_complete_game()
	parent.create_node()	
