extends Area2D
class_name alien_lazr
@export var speed = 100
func  _process(delta: float):
	position.y = position.y +3 + delta * speed


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		area.destroy_player()
		queue_free()
