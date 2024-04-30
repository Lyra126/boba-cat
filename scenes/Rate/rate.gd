extends Node2D

@onready var rating : TextureProgressBar = $Rating
var scene_text = {}
var selected_text = []
@export_file("*.json") var scene_text_file

var straw_p = preload("res://assets/final_station/straw_p.png")
var straw_y = preload("res://assets/final_station/straw_y.png")
var straw_g = preload("res://assets/final_station/straw_g.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_straw()
	if(global.hasLid):
		$cup/Lid.visible = true
	$Customer.texture = global.get_customer_texture(global.currCustomer)
	await get_tree().create_timer(1.0).timeout
	rateOrder()
	
func reset():
	global.dialogueCompleted = false
	global.orderShown = false
	global.hasCup = false
	global.reset_drink()
	global.nextCustomerCalled = false
	global.timeOver = false
	global.playerOrder = []
	global.randomIndex = randi() % global.allCustomers.size()
	global.currCustomer = global.allCustomers[global.randomIndex]
	global.time = 0.0
	global.mins = 0
	global.secs = 0
	global.timerInProgress = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func rateOrder():
	get_tree().paused = true
	rating.visible = true
	await get_tree().create_timer(1.0).timeout
	scene_text = load_scene_text()
	$Notif.visible = true
	var orderRating = checkOrder()
	print(orderRating)
	rating.value = orderRating
	$meow.play()
	showDialogue()
	reset()
	
	
	
func load_scene_text():
	var file = "res://scenes/Rate/finish.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		return (json_as_dict)
		
		
func checkOrder() -> int:
	var score
	var matchingComponents = 0
	print("checking if player made order correctly...")
	print("Player made: ", global.playerOrder)
	print("Order was: ", global.order)
	for playerItem in global.playerOrder:
		if playerItem in global.order:
			matchingComponents += 1
	print(matchingComponents)
	score = int(float(matchingComponents) / len(global.order) * 100)
	print("initial score, ", score)
	if  not global.hasLid:
		score -= 15
		print("no lid, score deducted by 15, ", score)
	if not global.hasStraw:
		score -= 15
		print("no straw, score deducted by 15, ", score)
	if global.timeOver:
		score -= 20
		print("time over, score deducted by 20, ", score)
	if(matchingComponents < len(global.playerOrder) and matchingComponents == len(global.order)):
		score -= (15 * (len(global.playerOrder) - len(global.order)))
		print("wrong additional components, score deducted by 15 each, ", score)
	return score
	
func showDialogue():
	$Label.visible = true;
	if rating.value <= 30 and rating.value >= 0:
		selected_text = scene_text["bad"].duplicate()
		$Label.text = selected_text.pop_front()
	elif rating.value <= 60 and rating.value > 30:
		selected_text = scene_text["good"].duplicate()
		$Label.text = selected_text.pop_front()
	elif rating.value <= 100 and rating.value > 60:
		selected_text = scene_text["excellent"].duplicate()
		$Label.text = selected_text.pop_front()
	get_tree().paused = false
		

func _on_diag_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			$Label.visible = false
			$Clear.visible = true
			await get_tree().create_timer(1.0).timeout
			$Notif.visible = false
			$Clear.visible = false
			get_tree().change_scene_to_file("res://scenes/customer_line/customer_line.tscn")

func get_straw():
	if global.straw_sprite == 'pink straw':
		$"cookies on tray/straw".show()
		$"cookies on tray/straw".set_texture(straw_p)
	elif global.straw_sprite == 'yellow straw':
		$"cookies on tray/straw".show()
		$"cookies on tray/straw".set_texture(straw_y)
	elif global.straw_sprite == 'green straw':
		$"cookies on tray/straw".show()
		$"cookies on tray/straw".set_texture(straw_g)
