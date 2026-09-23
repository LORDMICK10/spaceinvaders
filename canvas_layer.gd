extends CanvasLayer
@onready var h_box_container: HBoxContainer = $MarginContainer/HBoxContainer
@onready var points_label: Label = $"MarginContainer/Points Label"
@onready var life_manager: LIFE_MANAGER = $"../LIFE MANAGER"
@onready var center_container: CenterContainer = $MarginContainer/CenterContainer
@onready var texture_rect: TextureRect = $MarginContainer/TextureRect_Lost
@onready var texture_rect_won: TextureRect = $MarginContainer/TextureRect_Won
@onready var score_node: Score = $"../Score Node"
@onready var invader_spawner: InvaderSpawner = $"../Invader Spawner"
signal Game_start

var Life_Texture = preload("res://images/shooter ship.jpg")

func _ready():
	points_label.text = "Score:%d" %0
	life_manager.LIFE_LOST.connect(_on_life_lost)
	for i in range(life_manager.Lives):
		var life_texture_rect = TextureRect.new()
		life_texture_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
		life_texture_rect.custom_minimum_size = Vector2(40,25)
		life_texture_rect.texture = Life_Texture
		h_box_container.add_child(life_texture_rect)
	invader_spawner.GAME_LOST.connect(_on_GAME_LOST)
	invader_spawner.Game_Won.connect(_on_Game_Won)
	life_manager.GAME_LOST.connect(_on_GAME_LOST)
	score_node.Score_Change.connect(add_score)
		
func _on_life_lost(livesleft:int):
	if livesleft >=  0 :
		var Life = h_box_container.get_child(livesleft)
		Life.queue_free()
	
func add_score(points:int):
	points_label.text = "Score:%d" %points
	
func _on_GAME_LOST():
	center_container.visible = true
	texture_rect.visible = true
	
func _on_Game_Won():
	center_container.visible = true
	texture_rect_won.visible = true


func _on_button_pressed() -> void:
	Game_start.emit()
	center_container.visible = false
	texture_rect.visible = false
	texture_rect_won.visible = false
	score_node.reset_score()
