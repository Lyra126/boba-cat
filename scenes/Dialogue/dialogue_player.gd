
extends CanvasLayer

@export_file("*.json") var scene_text_file
var scene_text = {}
var selected_text = []
var in_progress = false
@onready var background = $Background
@onready var text_label = $TextLabel

func _ready():
	background.visible = false
	scene_text = load_scene_text()
	
func load_scene_text():
	var file = "res://scenes/Dialogue/dialogue.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		return (json_as_dict)
		
func show_text():
	text_label.text = selected_text.pop_front()
	
func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()
		
func finish():
	text_label.text = ""
	background.visible = false
	in_progress = false
	get_tree().paused = false
		
func display_dialogue(text_key):
	if in_progress:
		next_line()
	else:
		background.visible = true
		in_progress = true
		selected_text = scene_text[text_key].duplicate()
		show_text()


#func _on_dialog_area_mouse_entered() -> void:
	#on_display_dialogue("customer1")


func _on_dialog_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Test2")
			display_dialogue("customer1")


