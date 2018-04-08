extends Area2D

signal crash

const DIVE_ACCELERATION = 10
const FLY_ACCELERATION = -4
const CRASHED_ROTATION_SPEED = 3

enum BirdState { NONE, IDLE, NORMAL, CRASHED }

var ySpeed = 0
var maxYPos = 0
var birdState = BirdState.NONE

func _ready():
	$AnimatedSprite.play()

func reset(pos):
	ySpeed = 0
	position = pos
	birdState = BirdState.IDLE
	rotation = 0

func _process(delta):
	if birdState != BirdState.NONE && birdState != BirdState.IDLE:
		ySpeed += DIVE_ACCELERATION * delta
		setBirdY(position.y + ySpeed)

	if Input.is_action_pressed("tap") && birdState != BirdState.NONE && birdState != BirdState.CRASHED:
		fly(delta)

	setBirdAngle(delta)

func get_height():
	return 12 * $AnimatedSprite.scale.y

func fly(delta):
	if birdState == BirdState.IDLE:
		birdState = BirdState.NORMAL
	ySpeed = FLY_ACCELERATION
	position.y += ySpeed
	setBirdY(position.y + ySpeed)

func setBirdY(y):
	position.y = clamp(y, 0, maxYPos)

func setBirdAngle(delta):
	match birdState:
		BirdState.NORMAL:
			if ySpeed > 0:
				rotation = 0.4
			else:
				rotation = -0.4
		BirdState.CRASHED:
			rotation += PI * delta * CRASHED_ROTATION_SPEED

func _on_Bird_body_entered(body):
	emit_signal("crash")
	birdState = BirdState.CRASHED