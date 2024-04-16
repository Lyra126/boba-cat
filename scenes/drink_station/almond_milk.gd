extends Node2D

@onready var milk_anim = $almond_animations
@onready var milk_still = $almondSprite

var selected
var cup_droppable = false
var body_ref
var target_position
var pouring_milk
var offset = Vector2.ZERO
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
		global_position = lerp(global_position, Vector2(540, 340), 10 * delta)
		rotation = lerp_angle(rotation, 0, 10 * delta)
	
func smooth_back(delta):
	global_position = lerp(global_position, Vector2(540, 340), 10 * delta)

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
					global.SomethingBeingClickedRn = false
					selected = false
					smooth_back(get_physics_process_delta_time())

func _on_almond_animations_animation_finished() -> void:
	global.SomethingBeingClickedRn = false;
	milk_anim.stop()
	milk_anim.hide()
	milk_still.show()
	selected = false

func _on_almond_area_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group('cup_drop'):
		cup_droppable = true


func _on_almond_area_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group('cup_drop'):
		cup_droppable = false

func _on_almond_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("click") and not global.SomethingBeingClickedRn:
		selected = true
		global.SomethingBeingClickedRn = true;
		offset = get_global_mouse_position() - global_position