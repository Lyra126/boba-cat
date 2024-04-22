extends Node2D

@onready var milk_anim = $oat_animations
@onready var milk_still = $oatSprite
@onready var oat_milk_droppable = $"../oat milk droppable"

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
	
func _physics_process(delta):
	if selected:
		target_position = get_global_mouse_position() - offset
		global_position = lerp(global_position, target_position, 15 * delta) # Smooth animation during dragging
		look_at(get_global_mouse_position())
	else:
		global_position = lerp(global_position, oat_milk_droppable.global_position, 10 * delta)
		rotation = lerp_angle(rotation, 0, 10 * delta)
	
		
func _input(event):
	if selected:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				var mouse_position = get_viewport().get_mouse_position()
				if cup_droppable:
					milk_anim.show()
					milk_still.hide()
					if mouse_position.x > cup_droppable_position.x:
						if Input.is_action_just_pressed("click"):
							milk_anim.play("default")
					elif mouse_position.x < cup_droppable_position.x:
						if Input.is_action_just_pressed("click"):
							milk_anim.play("default")
				else:
					selected = false
					global.SomethingBeingClickedRn = false

func _on_oat_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("click") and not global.SomethingBeingClickedRn and liquid_station_global.fridge_open and not liquid_station_global.going_to_pour:
		selected = true
		global.SomethingBeingClickedRn = true;
		offset = get_global_mouse_position() - global_position
		global.liquids_poured.append("oat_milk")

func _on_oat_animations_animation_finished() -> void:
	selected = false
	global.SomethingBeingClickedRn = false;
	milk_anim.stop()
	milk_anim.hide()
	milk_still.show()

func _on_oat_area_body_entered(body: Node2D) -> void:
	if body.is_in_group('cup_drop'):
		cup_droppable = true
		
func _on_oat_area_body_exited(body: Node2D) -> void:
	if body.is_in_group('cup_drop'):
		cup_droppable = false
