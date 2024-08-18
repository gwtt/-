extends GameInit

@onready var post: Label = $"岗位"
@onready var salary: Label = $"工资"
@onready var graduation: Label = $"学历"

var move_time:float = 1.0

var post_dictionary = {
	1: "■■■",
	2: "■■",
	3: "■■■■",
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

func random_content():
	post.set_text(post_dictionary[randi_range(1,3)])
	salary.set_text(salary_dictionary[randi_range(1,6)])
	graduation.set_text(graduation_dictionary[randi_range(1,4)])

func _on_左边按钮_pressed() -> void:
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	var parent = get_node("../../")
	tween.tween_property(self,"global_position",parent.disappear_pass.global_position,move_time)
	await get_tree().create_timer(1).timeout
	self.queue_free()
	parent.count += 1
	if parent.count == 10:
		GlobalGameManager.emit_complete_game()
	parent.create_node()
	
func _on_右边按钮_pressed() -> void:
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	var parent = get_node("../../")
	tween.tween_property(self,"global_position",parent.disappear_post.global_position,move_time)
	await get_tree().create_timer(1).timeout
	self.queue_free()
	parent.count += 1
	print(parent.count)
	if parent.count == 10:
		GlobalGameManager.emit_complete_game()
	parent.create_node()	
