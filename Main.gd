extends Node2D

export (PackedScene) var Pipe
export (PackedScene) var Floor

const PIPES_GAP = 170

var score = 0
var pipes = []

func _ready():
	randomize()	
	$World/Bird.maxYPos = get_viewport_rect().size.y - $World/Floor.get_height()
	$World/Bird.position = $Position2D.position

func _process(delta):
	if Input.is_key_pressed(KEY_R):
		start_game()

	if !pipes.empty() && $World/Bird.birdState != $World/Bird.BirdState.CRASHED && !pipes[0][0].passed && pipes[0][0].position.x < $Position2D.position.x:
		pipes[0][0].passed = true
		score += 1
		$Score.text = str(score)

func start_game():
	for p in pipes:
		p[0].queue_free()
		p[1].queue_free()
	pipes.clear()

	$World/Bird.reset($Position2D.position)
	score = 0
	$Score.text = str(score)
	$GameTimer.start()

func _spawn_pipe():
	var top
	var bottom
	var isNew = false

	if pipes.size() < 3:
		top = Pipe.instance()
		bottom = Pipe.instance()
		bottom.set_flip(true)
		pipes.append([top, bottom])
		isNew = true
	else:
		var temp = pipes[0]
		top = temp[0]
		bottom = temp[1]
		top.passed = false
		pipes.remove(0)
		pipes.append(temp)
		isNew = false

	var h = int(top.get_height() * top.get_scale().y)
	var y = rand_range(200, int(h * 0.85))
	var x = get_viewport().size.x + 50;

	top.position.x = x
	top.position.y = -y
	bottom.position.x = x
	bottom.position.y = top.position.y + h + PIPES_GAP

	if isNew:
		$World.add_child(top)
		$World.add_child(bottom)

func _on_Bird_crash():
	pass
	$GameTimer.stop()
	$GameOver.start()

func _on_HUD_start():
	$HUD.hide()
	start_game()

func _on_GameOver_timeout():
	$HUD.show()
