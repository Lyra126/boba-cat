extends Node2D

var selected
var offset = Vector2.ZERO

var tea_droppable = false
var coffee_droppable = false
var smoothie_droppable = false

var target_position
var pouring_milk
var pour_milk_left = false
var pour_milk_right = true
var tea_droppable_position = Vector2(-925,-125)
var coffee_droppable_position = Vector2(-435,-125)

func _ready():
	global.SomethingBeingClickedRn = false;
	liquid_station_global.coffee_set_to_pour = false;
	liquid_station_global.tea_set_to_pour = false;

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
		if global_position.y < -100:
			scale = Vector2(0.75, 0.75)
		else:
			scale = Vector2(1, 1)

func _input(event):
	if selected:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if tea_droppable:
					print("placeholder")
				else:
					if global_position.x < -600 and global_position.x > -1000 and global_position.y < 100 and global_position.y > -500:
						global_position.x = -814.25
						global_position.y = 50
						scale = Vector2(0.5, 0.5)
					else:
						global_position = lerp(global_position, Vector2.ZERO, 1)
					selected = false
					global.SomethingBeingClickedRn = false;
					
		if liquid_station_global.nozzle_anim_playing:
			selected = false
			return


