extends Area2D
class_name UFO
signal UFO_destroyed
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var Speed = 200
func _process(delta: float) -> void: 
	position.x=position.x- Speed*delta
	
func _on_area_entered(area: Area2D) -> void:
	if area is Lazer:
		collision_shape_2d.queue_free()
		animation_player.play("ufoexplosion")
		UFO_destroyed.emit()
		area.queue_free()
		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
