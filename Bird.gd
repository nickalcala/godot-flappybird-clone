extends Area2D

signal crash

const DIVE_ACCELERATION = 0.7
const FLY_ACCELERATION = -0.25

var ySpeed = 0
var isCrashed = false

func _ready():
	$AnimatedSprite.play()

func _process(delta):

	ySpeed += DIVE_ACCELERATION * delta
	setBirdY(position.y + ySpeed)

	if Input.is_action_pressed("tap") && !isCrashed:
		fly(delta)

	setBirdAngle(delta)
	print("Bird = ", isCrashed)

func fly(delta):
	ySpeed = FLY_ACCELERATION
	position.y += ySpeed
	setBirdY(position.y + ySpeed)

func setBirdY(y):
	position.y = clamp(y, 0, get_viewport_rect().size.y)

func setBirdAngle(delta):
	if !isCrashed:
		if ySpeed > 0:
			rotation = 0.4
		else:
			rotation = -0.4
	else:
		rotation += PI * delta * 5

func _on_Bird_body_entered(body):
	emit_signal("crash")
	isCrashed = true