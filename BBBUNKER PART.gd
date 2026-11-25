extends Area2D
@export var sprite:Sprite2D
@export var textures:Array[Texture2D]
var canvas_layer



var damage = 0
func _ready() -> void:   
	self.area_entered.connect(on_area_entered)
	canvas_layer = get_tree().current_scene.get_node("%CanvasLayer")
	canvas_layer.Game_start.connect(on_Game_start)
	

func on_area_entered(area):
	if area is Lazer || area is alien_lazr:
		area.queue_free()
		if damage < 3:
			damage += 1
			sprite.texture = textures[damage  ]
			 
		else:
			queue_free()
	if area is Invader:
		queue_free()
	
func on_Game_start():
	sprite.texture = textures[0]
	damage = 0
	
