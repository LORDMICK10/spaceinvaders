extends Node2D
var alien_lazer = preload("res://alien_lazer_area_2d.tscn")
@onready var invader_spawner: InvaderSpawner = $"../Invader Spawner"
var UFOO
@onready var life_manager: LIFE_MANAGER = $"../LIFE MANAGER"



@export var UFOscene:PackedScene
@onready var ufo_spawn_timer: Timer = $Spawn_Timer
@onready var shoot_timer: Timer = $"Shoot Timer"

func _ready() -> void:
	ufo_spawn_timer.Timer_Setup()   
	life_manager.GAME_LOST.connect(on_Game_Over)
	invader_spawner.Game_Won.connect(on_Game_Over)
	
func _on_spawn_timer_timeout() -> void:
 
	shoot_timer.start()
	UFOO = UFOscene.instantiate()
	UFOO.global_position = position
	UFOO.UFO_destroyed.connect(_on_UFO_destroyed)
	get_tree().root.add_child(UFOO)


func _on_shoot_timer_timeout() -> void:
	
	var lazr = alien_lazer.instantiate() as alien_lazr
	if lazr:
		lazr.global_position = UFOO.global_position 
		get_tree().root.add_child(lazr)
		

func _on_UFO_destroyed() -> void:
	shoot_timer.stop()
	
	
func on_Game_Over():
	ufo_spawn_timer.stop()
	shoot_timer.stop()
