extends Node2D
class_name InvaderSpawner
@onready var timer: Timer = $Timer
@onready var shoot_timer: Timer = $"Shoot Timer"
@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"
@onready var life_manager: LIFE_MANAGER = $"../LIFE MANAGER"

var direction = 1
var alien_lazers = preload("res://alien_lazer_area_2d.tscn")
var invader_count = 0
var invader_scene = preload("res://invader.tscn")

signal invader_destroyed(points:int)
signal Game_Won
signal GAME_LOST
signal game_restart

const START_Y = 100
const  START_X = 200
const  WIDTH = 150
const  HEIGHT = 100
const ROWS = 3
const COLS = 5
const HORIZ_MOVE = 10
const VERTICAL = 20
var invade_total = ROWS * COLS

 
func _ready():
	canvas_layer.Game_start.connect(_on_game_restart)
	life_manager.GAME_LOST.connect(_on_GAME_LOST)
	
	start_game()
	
	
func start_game():
	for row in ROWS:
		var  y = START_Y + (row * HEIGHT)
		for col in COLS:
			var invader = invader_scene.instantiate()as Invader
			var x = START_X + col * WIDTH
			invader.invade_destroyed.connect(_on_invade_destroyed)
			invader.global_position = Vector2(x,y)
			add_child(invader)
	timer.start()
	shoot_timer.start()
	timer.timeout.connect(moveinvaders)
	shoot_timer.timeout.connect(invader_shoot)
	
func stop_game():
	shoot_timer.stop()
	timer.stop()
	
	var ships = get_children()
	for ship in ships:
		remove_child(ship)
	
func _on_game_restart():
	position.x = 0
	position.y = 0
	start_game()
	invader_count = 0
	direction = 1

func moveinvaders():
	position.x += HORIZ_MOVE * direction
	

func invader_shoot():
	var ship = find_invader()
	if ship:
		var lazr = alien_lazers.instantiate() as alien_lazr
		if lazr:
			lazr.global_position = ship.global_position 
			get_tree().root.add_child(lazr)
	

			
func _on_left_wall_area_entered(_area: Area2D) -> void:
	if direction == -1:
		direction = 1
		position.y +=VERTICAL


func _on_right_wall_area_entered(_area: Area2D) -> void:
	if direction == 1:
		direction = -1
		position.y += VERTICAL

func is_child(child): 
	return child is Invader      

func find_invader():
	var shipfound = null
	var children = get_children()
	var ships = children.filter(is_child)
	if ships.size()>0:
		var index = randi_range(0,ships.size()-1)
		shipfound = ships[index]        
	return shipfound
	 
func _on_invade_destroyed(points:int):
	invader_destroyed.emit(points)
	invader_count +=1
	if invader_count >= invade_total:
		Game_Won.emit()
		stop_game()
		

	
@warning_ignore("unused_parameter")
func _on_bottom_wall_area_2d_area_entered(area: Area2D) -> void:   
	GAME_LOST.emit()
	stop_game()
	
func _on_GAME_LOST():
	stop_game()
