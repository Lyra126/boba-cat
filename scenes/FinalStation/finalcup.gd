extends Node2D

var selected
var offset = Vector2.ZERO

var tea_droppable = false
var coffee_droppable = false
var smoothie_droppable = false

var target_position
var overlapMachine
var finalStation
var original_position
var openMachine = preload("res://assets/final_station/openMachine.png")
var closeMachine = preload("res://assets/final_station/closeMachine.png")
var hasLid

func _process(delta):
	pass
	
func _on_cup_pick_up_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") and not global.SomethingBeingClickedRn:
		selected = true
		global.SomethingBeingClickedRn = true;
		offset = get_global_mouse_position() - global_position


func _physics_process(delta):
	if selected:
		target_position = get_global_mouse_position() - offset
		global_position = lerp(global_position, target_position, 15 * delta)
		if global_position.y < 500:
			scale = Vector2(0.60, 0.60)
		else:
			scale = Vector2(0.75, 0.75)


func _on_attach_lid_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if selected and $Lid.visible == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				get_tree().paused = true
				scale = Vector2(0.60, 0.60)
				$".".position.x = $"../AttachLid".position.x
				$".".position.y = $"../AttachLid".position.y
				print("snap")
				addLid()
				get_tree().paused = false
			selected = false
			global.SomethingBeingClickedRn = false;
				
func addLid():
	#wait one second
	await get_tree().create_timer(1.0).timeout
	$".".position.y = $".".position.y - 120
	$"../lid machine/lid machine normal sprite".hide()
	$"../lid machine/lid machine close sprite".show()
	#move cup up
	await get_tree().create_timer(1.5).timeout
	$"../lid machine/lid machine close sprite".hide()
	$"../lid machine/lid machine normal sprite".show()
	$".".position.y = $".".position.y + 120
	$Lid.visible = true
	hasLid = true
	scale = Vector2(0.60, 0.60)
	pass


func _on_initial_pos_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if selected and hasLid:
				selected = false
				print("deselect cookie")
				$".".position.x = $"../InitialPos".position.x
				$".".position.y = $"../InitialPos".position.y-310
