extends Node2D

@onready var post: Label = $"岗位"
@onready var salary: Label = $"工资"
@onready var graduation: Label = $"学历"

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
