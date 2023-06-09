extends Node2D

var tween

func _ready():
	Global.canMove = true
	Global.canChange = false
	if OS.get_name() == "Android":
		$CanvasLayer/Label.queue_free()

func _physics_process(_delta):
	if Global.canChange == true and Input.is_action_just_pressed("ui_accept"):
		$CanvasLayer/VideoPlayer.show()
		$CanvasLayer/VideoPlayer.play()
	if Input.is_action_just_pressed("Pause"):
		if Global.isPaused == false:
			Global.isPaused = true
			get_tree().paused = true
		else:
			Global.isPaused = false
			get_tree().paused = false
	if Input.is_action_just_pressed("Restart"):
		var _useValue = get_tree().reload_current_scene()

func _on_Player_dead():
	$DeathSound.play()

func _on_DeathSound_finished():
	var _useValue = get_tree().reload_current_scene()

func _on_Star_GotStar():
	$ScreamSound.play()

func _on_Player_next():
	Global.canChange = true
	$CanvasLayer/Label.show()

func _on_VideoPlayer_finished():
	Global.index += 1
	var _useValue = get_tree().change_scene_to_file(Global.levels[Global.index])

func _on_Brick_broken():
	$FartSound.play()

func _on_control_next():
	$CanvasLayer/VideoPlayer.show()
	$CanvasLayer/VideoPlayer.play()

func _on_spikes_kill():
	Global.canMove = false
	$DeathSound2.play()
	tween = create_tween()
	tween.tween_property($Player, "modulate", Color(255, 255, 255, 0), 0.5)
#	tween.tween_callback($Player.queue_free).set_delay(0.5)
