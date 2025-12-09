extends Control

func _ready():
	hide()
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	get_node("PauseButtons").position = Vector2(-999,-999)
	$AnimationPlayer.play_backwards("pause")
	hide()

func pause():
	get_tree().paused = true
	get_node("PauseButtons").position = Vector2(85.5,36.5)
	$AnimationPlayer.play("pause")
	show()

func testEsc():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		resume()


func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()

func _process(delta):
	testEsc()
