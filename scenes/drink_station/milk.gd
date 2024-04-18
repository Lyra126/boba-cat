extends Node2D

@onready var milk_anim = $milk_animations
@onready var milk_still = $milkSprite
@onready var cow_milk_droppable = $"../cow milk droppable"

var selected
var offset = Vector2.ZERO
var cup_droppable = false
var body_ref
var target_position
var pouring_milk
var pour_milk_left = false
var pour_milk_right = true
var cup_droppable_position = Vector2(-200,173)

# Called when the node enters the scene tree for the first time.
func _ready():
	milk_still.show()
	milk_anim.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_milk_area_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("click") and not global.SomethingBeingClickedRn and liquid_station_global.fridge_open and not liquid_station_global.going_to_pour:
		selected = true
		global.SomethingBeingClickedRn = true;
		offset = get_global_mouse_position() - global_position
	
func _physics_process(delta):
	if selected:
		target_position = get_global_mouse_position() - offset
		global_position = lerp(global_position, target_position, 15 * delta) # Smooth animation during dragging
		look_at(get_global_mouse_position())
	else:
		global_position = lerp(global_position, cow_milk_droppable.global_position, 10 * delta)
		rotation = lerp_angle(rotation, 0, 10 * delta)
		
func _on_milk_animations_animation_finished():
	selected = false
	global.SomethingBeingClickedRn = false;
	milk_anim.stop()
	milk_anim.hide()
	milk_still.show()
	
#func restrict_mouse_area(): < - maybe implement if we have time, want to restrict the mouse area when the animation is playing
	#var mouse_position = get_viewport().get_mouse_position()
	#if not allowed_area.has_point(mouse_position):
		#var clamped_x = clamp(mouse_position.x, allowed_area.position.x, allowed_area.position.x)
		#var clamped_y = clamp(mouse_position.y, allowed_area.position.y, allowed_area.position.y)
		#get_viewport().warp_mouse(Vector2(clamped_x, clamped_y))
		
func _input(event):
	if selected:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				var mouse_position = get_viewport().get_mouse_position()
				print(mouse_position)
				if cup_droppable:
					milk_anim.show()
					milk_still.hide()
					if mouse_position.x > cup_droppable_position.x:
						if Input.is_action_just_pressed("click"):
							milk_anim.play("pouring_milk_right")
					elif mouse_position.x < cup_droppable_position.x:
						if Input.is_action_just_pressed("click"):
							milk_anim.play("pouring_milk_left")
				else:
					selected = false
					global.SomethingBeingClickedRn = false


func _on_milk_area_body_entered(body):
	if body.is_in_group('cup_drop'):
		cup_droppable = true

func _on_milk_area_body_exited(body):
	if body.is_in_group('cup_drop'):
		cup_droppable = false

