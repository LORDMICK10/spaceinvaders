extends Node

class_name LIFE_MANAGER
signal LIFE_LOST(Livesleft:int)
signal GAME_LOST
@export var Lives = 3
@onready var player:Player = $"../Player"
var PlayerScene = preload("res://player.tscn")
func _ready() -> void:
	player.player_destroyed.connect(_on_player_destroyed)


func _on_player_destroyed():
	Lives = Lives -1
	LIFE_LOST.emit(Lives)
 
	player = PlayerScene.instantiate()
	player.global_position = Vector2(696,587)
	player.player_destroyed.connect(_on_player_destroyed)
	get_tree().root.get_node("Main").add_child(player)
	
	if Lives < 1:
		GAME_LOST.emit()
