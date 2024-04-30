extends Node2D

@onready var anim = $"../cup/liquid-in-cup/Polygon2D/liquid_animations"
@onready var syrup_down = $syrup_down
@onready var syrup_still = $syrupSprite
@onready var syrup_position = $"../sugar_syrup_droppable"
@onready var particle = $sugar_particle
var syrupLevels = ["sugar", "sugar-25", "sugar-50", "sugar-75", "sugar-100"]

var selected
var offset = Vector2.ZERO
var cup_droppable = false
var body_ref
var syrupIndex
var syrupAdded = false
var target_position
var syrup_level_max = false

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
		rotation = lerp_angle(rotation, 0, 10 * delta)
		
func _input(event):
	if selected:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				var mouse_position = get_viewport().get_mouse_position()
				if cup_droppable:
					syrup_still.hide()
					syrup_down.show()
					syrup_down.play('default')
					$"../sugar".play()

					if not syrupAdded:
						global.playerOrder.append("sugar-25")
						syrupAdded = true
						print("level = 25")
						syrup_down.show()
						syrup_down.play("default")
						# try to make the drink lighter every time sugar is added.?
						
					else:
						for syrupLevel in syrupLevels:
							syrupIndex = global.playerOrder.find(syrupLevel)
							if syrupIndex != -1:
								if(syrupLevel) == "sugar-25":
									global.playerOrder.remove_at(syrupIndex)
									global.playerOrder.append("sugar-50")
									print("level = 50")
									syrup_down.show()
									syrup_down.play("default")
								elif(syrupLevel) == "sugar-50":
									global.playerOrder.remove_at(syrupIndex)
									global.playerOrder.append("sugar-75")
									print("level = 75")
									syrup_down.show()
									syrup_down.play("default")
								elif(syrupLevel) == "sugar-75":
									global.playerOrder.remove_at(syrupIndex)
									global.playerOrder.append("sugar-100")
									print("level = 100")
									syrup_down.show()
									syrup_down.play("default")
									#syrup_down.play("default")
								elif(syrupLevel) == "sugar-100":
									syrup_level_max = true
									selected = false
									global.SomethingBeingClickedRn = false
								break
				
				else:
					selected = false
					smooth_back(get_physics_process_delta_time())
					global.SomethingBeingClickedRn = false
					
func smooth_back(delta):
	global_position = lerp(global_position, syrup_position.global_position, 10 * delta)

func _on_syrup_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and not global.SomethingBeingClickedRn:
			if global.hasLid or syrup_level_max:
				shake_sprite()
			else:
				selected = true
				global.SomethingBeingClickedRn = true;
				offset = get_global_mouse_position() - global_position
				#$"../cup/liquid-in-cup/Polygon2D/liquid".start_timer()
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			selected = false
			global.SomethingBeingClickedRn = false;


func _on_syrup_area_body_entered(body: Node2D) -> void:
	if body.is_in_group('cup_drop')and global.hasCup:
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
	if syrup_down.is_playing() and not syrup_level_max:
		particle.emitting = true

func shake_sprite():
	var tween = get_tree().create_tween()  # Ensure the Tween node/component is correctly referenced
	var r_max = 2
	tween.tween_property(self, "rotation_degrees", r_max, 0.05).set_ease(Tween.EASE_OUT)
