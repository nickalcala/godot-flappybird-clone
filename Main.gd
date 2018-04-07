extends Node2D

export (PackedScene) var Pipe
export (PackedScene) var Floor

const PIPES_GAP = 170

func _ready():
	randomize()
	$Bird.position = $Position2D.position
	$Background.position.y = get_viewport_rect().size.y * -0.3

func start_game():
	$Bird.position = $Position2D.position
	$Bird.isCrashed = false
	print("Main = ", $Bird.isCrashed)

func _spawn_pipe():
	var top = Pipe.instance()
	var bottom = Pipe.instance()
	var h = int(top.get_height() * top.get_scale().y)
	var y = rand_range(200, int(h * 0.85))
	var x = get_viewport().size.x + 50;
	
	top.position.x = x
	top.position.y = -y
	bottom.set_flip(true)
	bottom.position.x = x
	bottom.position.y = top.position.y + h + PIPES_GAP

	add_child(top)
	add_child(bottom)

func _on_Bird_crash():
	start_game()
	$Timer.stop()