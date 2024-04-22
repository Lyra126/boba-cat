extends Node2D

@onready var rating : TextureProgressBar = $Rating
var scene_text = {}
var selected_text = []
@export_file("*.json") var scene_text_file

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	rateOrder()
	#$Clear.visible = true
	#await get_tree().create_timer(1.0).timeout
	#get_tree().change_scene_to_file("res://scenes/customer_line/customer_line.tscn")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func rateOrder():
	get_tree().paused = true
	rating.visible = true
	await get_tree().create_timer(1.0).timeout
	scene_text = load_scene_text()
	$Notif.visible = true
	showDialogue()
	rating.value = 50
	
	
	
func load_scene_text():
	var file = "res://scenes/Rate/finish.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		return (json_as_dict)
		
		
func checkOrder():
	var ordersMatch = false
	print("checking if player made order correctly...")
	if len(global.order) == len(global.playerOrder):
		for i in range(len(global.order)):
			if global.order[i] != global.playerOrder[i]:
				return
		ordersMatch = true
	else:
		print("Arrays have different lengths, cannot compare elements.")
	
func showDialogue():
	$Label.visible = true;
	if $Rating.value <= 30 and $Rating.value >= 0:
		selected_text = scene_text["bad"].duplicate()
		$Label.text = selected_text.pop_front()
	elif $Rating.value <= 60 and $Rating.value > 30:
		selected_text = scene_text["good"].duplicate()
		$Label.text = selected_text.pop_front()
	elif $Rating.value <= 100 and $Rating.value > 60:
		selected_text = scene_text["excellent"].duplicate()
		$Label.text = selected_text.pop_front()
	get_tree().paused = false
		
	
	


func _on_diag_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				await get_tree().create_timer(1.0).timeout
				$Label.visible = false
				$Clear.visible = true
				await get_tree().create_timer(1.0).timeout
				$Notif.visible = false
				$Clear.visible = false
				get_tree().change_scene_to_file("res://scenes/customer_line/customer_line.tscn")

