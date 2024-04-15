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
var tea_droppable_position = Vector2(140,260)
var coffee_droppable_position = Vector2(360,260)
var smoothie_droppable_position = Vector2(590,260)

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
		if global_position.y < 270:
			scale = Vector2(0.75, 0.75)
		else:
			scale = Vector2(1, 1)

func _input(event):
	if selected:
		if liquid_station_global.nozzle_anim_playing:
			selected = false
			return

		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			handle_liquid_selection(event)

func handle_liquid_selection(event):
	# Determine which liquid is droppable
	var is_tea = tea_droppable and not liquid_station_global.tea_set_to_pour
	var is_coffee = coffee_droppable and not liquid_station_global.coffee_set_to_pour
	var is_smoothie = smoothie_droppable and not liquid_station_global.smoothie_set_to_pour
	
	# Reset selections
	selected = false
	global.SomethingBeingClickedRn = false

	if is_tea:
		liquid_station_global.tea_set_to_pour = true
		print("tea can pour")
		global_position = lerp(global_position, tea_droppable_position, 1)
		selected = false

	elif is_coffee:
		liquid_station_global.coffee_set_to_pour = true
		print("coffee can pour")
		global_position = lerp(global_position, coffee_droppable_position, 1)
		selected = false
		
	elif is_smoothie:
		liquid_station_global.smoothie_set_to_pour = true
		print("smoothie can pour")
		global_position = lerp(global_position, smoothie_droppable_position, 1)
		selected = false

	else:
		# Reset pouring state to allow re-selection
		liquid_station_global.tea_set_to_pour = false
		liquid_station_global.coffee_set_to_pour = false
		liquid_station_global.smoothie_set_to_pour = false
		global_position = lerp(global_position, Vector2(580,335), 1)
		scale = Vector2(1, 1)  # Reset scale if needed
	

func _on_cup_pick_up_body_entered(body):
	if body.is_in_group('tea-droppable'):
		tea_droppable = true
	elif body.is_in_group('coffee-droppable'):
		coffee_droppable = true
	elif body.is_in_group('smoothie-droppable'):
		smoothie_droppable = true

func _on_cup_pick_up_body_exited(body):
	if body.is_in_group('tea-droppable'):
		tea_droppable = false
	elif body.is_in_group('coffee-droppable'):
		coffee_droppable = false
	elif body.is_in_group('smoothie-droppable'):
		smoothie_droppable = false

func _on_tea_nozzle_down_animation_finished():
	selected = true
	
func _on_coffee_nozzle_down_animation_finished():
	selected = true

func _on_smoothie_nozzle_down_animation_finished():
	selected = true
