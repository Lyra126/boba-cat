extends Node2D

@onready var cup_spot = $"../cup_spot"

var selected
var offset = Vector2.ZERO

var target_position
var overlapMachine
var finalStation
var original_position
var tray_droppable
var cup_down

func _process(delta):
	pass
	
func _on_cup_pick_up_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") and not global.SomethingBeingClickedRn and not cup_down:
		selected = true
		global.SomethingBeingClickedRn = true;
		offset = get_global_mouse_position() - global_position

func _input(event):
	if selected:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if tray_droppable:
					$".".global_position.x = cup_spot.global_position.x
					$".".global_position.y = cup_spot.global_position.y
					selected = false
					global.SomethingBeingClickedRn = false

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
	global.hasLid = true
	scale = Vector2(0.60, 0.60)
	pass

func _on_cup_pick_up_body_entered(body: Node2D) -> void:
	if body.is_in_group('tray'):
		tray_droppable = true

func _on_cup_pick_up_body_exited(body: Node2D) -> void:
	if body.is_in_group('tray'):
		tray_droppable = false
