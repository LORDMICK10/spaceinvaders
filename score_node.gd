extends Node
class_name Score
signal Score_Change(points:int)
var score = 0

@onready var invader_spawner: InvaderSpawner = $"../Invader Spawner"

func _ready() -> void:
	invader_spawner.invader_destroyed.connect(increase_score)
	
func reset_score():
	score = 0
	
func increase_score(points:int):
	score += points
	Score_Change.emit(score)
	

func _reset_score():
	score = 0
	
	
