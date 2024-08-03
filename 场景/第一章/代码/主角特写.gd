extends GameInit

@onready var 主角 = $"白色框/主角"
var flag = false

func _ready():
	_init_game()
	var timer = Timer.new()
	timer.set_wait_time(1)
	timer.connect("timeout",Callable(self,"_眨眼"))
	add_child(timer)
	timer.start()


func _init_game():
	flag = true
	
func _眨眼():
	if flag:
		主角.play("眨眼")
