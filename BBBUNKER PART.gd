extends Area2D
@export var sprite:Sprite2D
@export var textures:Array[Texture2D]
var damage = 0
func _ready() -> void:   
	self.area_entered.connect(on_area_entered)

func on_area_entered(area):
	if area is Lazer || area is alien_lazr:
		area.queue_free()
		if damage < 3:
			damage += 1
			sprite.texture = textures[damage -1]
			 
		else:
			queue_free()
	if area is Invader:
		queue_free()
	
	
