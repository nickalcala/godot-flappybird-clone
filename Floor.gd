extends Area2D

const FLOOR_ACCELERATION = 80

func _process(delta):
	$Sprite.position.x -= FLOOR_ACCELERATION * delta
	$Sprite2.position.x -= FLOOR_ACCELERATION * delta
	if $Sprite.position.x <= -(get_width($Sprite)):
		$Sprite.position.x = $Sprite2.position.x + get_width($Sprite2)
	if $Sprite2.position.x <= -(get_width($Sprite2)):
		$Sprite2.position.x = $Sprite.position.x + get_width($Sprite)

func get_height():
	return $Sprite.texture.get_height() * $Sprite.scale.y

func get_width(sprite):
	return sprite.texture.get_width() * sprite.scale.x