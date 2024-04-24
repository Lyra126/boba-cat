extends Node2D

@onready var syrup_down = $syrup_down
@onready var syrup_still = $syrupSprite
@onready var syrup_position = $"../sugar_syrup_droppable"
@onready var particle = $sugar_particle

var selected
var offset = Vector2.ZERO
var cup_droppable = false
var body_ref
var target_position

# Called when the node enters the scene tree for the first time.
func _ready():
	syrup_still.show()
	syrup_down.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	particle_explosion()
	
func _physics_process(delta):
	if selected:
		target_position = get_global_mouse_position() - offset
		global_position = lerp(global_position, target_position, 15 * delta) # Smooth animation during dragging
	else:
		global_position = lerp(global_position, syrup_position.global_position, 10 * delta)
		
func _input(event):
	if selected:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				var mouse_position = get_viewport().get_mouse_position()
				if cup_droppable:
					syrup_still.hide()
					syrup_down.show()
					syrup_down.play("default")
				
				else:
					selected = false
					smooth_back(get_physics_process_delta_time())
					global.SomethingBeingClickedRn = false
					
func smooth_back(delta):
	global_position = lerp(global_position, Vector2.ZERO, 10 * delta)

func _on_syrup_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("click") and not global.SomethingBeingClickedRn:
		selected = true
		global.SomethingBeingClickedRn = true;
		offset = get_global_mouse_position() - global_position
		#$"../cup/liquid-in-cup/Polygon2D/liquid".start_timer()
	if Input.is_action_pressed("right_click"):
		selected = false
		global.SomethingBeingClickedRn = false;


func _on_syrup_area_body_entered(body: Node2D) -> void:
	if body.is_in_group('cup_drop'):
		cup_droppable = true


func _on_syrup_area_body_exited(body: Node2D) -> void:
	if body.is_in_group('cup_drop'):
		cup_droppable = false

func _on_syrup_down_animation_finished() -> void:
	#selected = false
	#global.SomethingBeingClickedRn = false;
	syrup_down.stop()
	syrup_down.hide()
	syrup_still.show()
	particle.emitting = false

func particle_explosion():
	if syrup_down.is_playing():
		particle.emitting = true
