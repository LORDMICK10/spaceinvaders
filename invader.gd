extends Area2D
class_name  Invader
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
signal invade_destroyed(points:int)

@onready var animation_player: AnimationPlayer = $AnimationPlayer
func _ready():
	sprite_2d.texture = preload("res://images/alie ship.png")
	 
func _on_area_entered(area: Area2D) -> void:
	if area is Lazer:
		collision_shape_2d.queue_free()
		animation_player.play("xplosion anima")
		area.queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "xplosion anima":
		queue_free()
		invade_destroyed.emit(10)
