extends Node2D
@export var lazer_scene: PackedScene
var maximumlazr = 2                           
var can_shoot = 0
@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("shoot"):
		if can_shoot < maximumlazr:
			can_shoot = can_shoot + 1
			
			var lazr = lazer_scene.instantiate()as Lazer
			lazr.global_position = get_parent().global_position
			get_tree().root.get_node("Main").add_child(lazr)			
			lazr.tree_exited.connect(lazr_destroyed)



func lazr_destroyed():
	can_shoot = can_shoot - 1
	
	
	
