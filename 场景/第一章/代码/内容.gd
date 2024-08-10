extends Node2D
@onready var 管理器 = $".."
#是否点过了
var flag = false
var flag_good = false:
	set(value):
		flag_good = value
		emit_signal("press_good_signal")
var flag_bad = false:
	set(value):
		flag_bad = value
		emit_signal("press_bad_signal")
signal press_good_signal
signal press_bad_signal
func press_good():
	if !flag:
		管理器.count += 1
		flag = true
	if flag_good:
		return
	if flag_bad:
		flag_bad = false
	flag_good = true

func press_bad():
	if !flag:
		管理器.count += 1
		flag = true
	if flag_bad:
		return
	if flag_good:
		flag_good = false
	flag_bad = true	
