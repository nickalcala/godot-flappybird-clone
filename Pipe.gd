extends KinematicBody2D

const PIPE_ACCELERATION = 80

var passed = false

func _process(delta):
	position.x -= PIPE_ACCELERATION * delta

func set_flip(flip):
	$Sprite.flip_v = flip

func get_height():
	return $Sprite.texture.get_height()

func get_scale():
	return $Sprite.scale