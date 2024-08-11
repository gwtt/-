extends Node2D

@onready var card = $Card
@onready var card_2 = $Card2
@onready var card_3 = $Card3
@onready var card_4 = $Card4
@onready var card_5 = $Card5
@onready var card_6 = $Card6
var judge_card = []
var count_card = 0

func _limit_child(boolean):
	print(boolean)
	for child in get_children():
		child._if_can_not_pressed(boolean)

func _append_card(node):
	judge_card.append(node)
	if judge_card.size()==2:
		_check_and_process_match()

func _check_and_process_match():
	var first_card = judge_card[0]
	var second_card = judge_card[1]
	# 检查是否匹配
	if ((first_card == card && second_card == card_4) or
		(first_card == card_4 && second_card == card) or
		(first_card == card_2 && second_card == card_5) or
		(first_card == card_5 && second_card == card_2) or
		(first_card == card_3 && second_card == card_6) or
		(first_card == card_6 && second_card == card_3)):
		first_card._destroy()
		second_card._destroy()
		await get_tree().create_timer(2).timeout
	else:
		first_card._flip()
		second_card._flip()
	# 重置选中按钮数组
	judge_card.clear()
	_limit_child(false)
	count_card = 0
