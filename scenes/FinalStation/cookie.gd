extends Sprite2D
var selected
var target_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta):
	if selected:
		target_position = get_global_mouse_position() - offset
		global_position = lerp(global_position, target_position, 15 * delta)

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#if selected:
				#$".".position.x = $"../cookieSpot".position
				#$".".position.y = 50

func _on_case_collision_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("cookie")
			selected = !selected
			$".".visible = !$".".visible
		

func _on_cookie_spot_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if selected:
				selected = false
				$".".position.x = $"../cookieSpot".position.x
				$".".position.y = $"../cookieSpot".position.y
