extends Area2D
class_name Player
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var speed = 200
signal player_destroyed 
var direction = Vector2.ZERO

func _ready() -> void:
	sprite_2d.scale = Vector2(1,1)

func _process(delta):
	var input = Input.get_axis("move_left","move_right")
	if input > 0:
		direction = Vector2.RIGHT
	elif input < 0:
		direction = Vector2.LEFT
	else:
		direction = Vector2.ZERO
		
	var vp = get_viewport()
	var x = 	position.x + delta * direction.x * speed
	var hlfwidth = sprite_2d.get_rect().size.x * scale.x/2
	if x > hlfwidth and x < vp.size.x - hlfwidth:
		position.x = x

func destroy_player():
	animation_player.play("ship_KABOOM")
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "ship_KABOOM":
		await get_tree().create_timer(1).timeout
		player_destroyed.emit()
		queue_free()
