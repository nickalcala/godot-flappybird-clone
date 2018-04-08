extends CanvasLayer

signal start

func _on_Button_pressed():
	emit_signal("start")

func hide():
	$ColorRect.hide()
	$Button.hide()

func show():
	$ColorRect.show()
	$Button.show()