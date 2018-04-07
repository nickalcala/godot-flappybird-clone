extends KinematicBody2D

const PIPE_ACCELERATION = 80

func _process(delta):
	position.x -= PIPE_ACCELERATION * delta

func _on_VisibilityEnabler2D_screen_exited():
	queue_free()

func set_flip(flip):
	$Sprite.flip_v = flip

func get_height():
	return $Sprite.texture.get_height()

func get_scale():
	return $Sprite.scale