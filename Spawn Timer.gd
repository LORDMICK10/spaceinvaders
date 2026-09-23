extends Timer
class_name Spawn_Timer
@export var min_time = 5
@export var max_time = 10
func  _ready() -> void:
	Timer_Setup()
func Timer_Setup():
		var  randomtime = randi_range(min_time,max_time)
		wait_time = randomtime
		stop()
		start()
