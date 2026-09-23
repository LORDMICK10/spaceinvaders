extends Area2D
class_name Lazer
@export var speed = 300
func _process(delta):
	position.y-= delta * speed
