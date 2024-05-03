extends Node2D

@onready var rating : TextureProgressBar = $Rating
var scene_text = {}
var selected_text = []
@export_file("*.json") var scene_text_file = ""

var straw_p = preload("res://assets/final_station/straw_p.png")
var straw_y = preload("res://assets/final_station/straw_y.png")
var straw_g = preload("res://assets/final_station/straw_g.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_straw()
	if global.hasLid:
		$cup/Lid.visible = true
	$Customer.texture = global.get_customer_texture(global.currCustomer)
	await get_tree().create_timer(1.0).timeout
	rateOrder()
	if not global.shownRate:
		await(get_tree().create_timer(3.5)).timeout
		$tutorial.show()

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

func rateOrder():
	get_tree().paused = true
	rating.visible = true
	await(get_tree().create_timer(1.0)).timeout
	scene_text = load_scene_text()
	$Notif.visible = true
	var orderRating = checkOrder()["score"]
	print("Order rating: ", orderRating)
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

func rand_text(messages: Array) -> String:
	return messages[randi() % messages.size()]
	
func format_item_name(item_name: String) -> String:
	var name_mapping = {
		"popping-boba": "popping boba",
		"sugar-cookies": "sugar cookies",
		"chocolate-cookie": "chocolate chip cookies",
		"tea": "tea",
		"cat-cookie": "cat cookies",  # Add more mappings as necessary
		"sugar-cookie": "sugar cookie",
		"almond-milk": "almond milk",
		"cow-milk": "cow milk",
		"oat-milk": "oat milk",
		"coffee": "coffee",
		"smoothie": "smoothie",
		"dalgona-chunks": "dalgona chunks",
		"sugar-25": "25% sugar",
		"sugar-50": "50% sugar",
		"sugar-75": "75% sugar",
		"sugar-100": "100% sugar",
		"fruit-jelly": "fruit jelly",
		"strawberry-slices": "strawberry slices",
		"boba": "boba",
		"coffee2": "extra coffee",
		"smoothie2": "extra smoothie",
		"tea2": "extra tea",
		"cow-milk2": "extra cow milk",
		"almond-milk2": "extra almond milk",
		"oat-milk2": "extra oat milk"
		 # Add other backend names and their readable counterparts here
	}
	return name_mapping.get(item_name, item_name)  # Return the item name if it's not found in the map

func format_list(items: Array) -> String:
	if items.size() == 1:
		return items[0]
	else:
		return ", ".join(items.slice(0, items.size() - 1)) + " or " + items[-1]

func checkOrder() -> Dictionary:
	var score
	var matchingComponents = 0
	var issues = []
	var unexpectedItems = [] 
	var forgottenItems = []  # List to hold forgotten items
	print("checking if player made order correctly...")
	print("Player made: ", global.playerOrder)
	print("Order was: ", global.order)
	
	# Possible messages
	var noLidMessages = [
		"Where's the lid?",
		"Did you forget my lid?",
		"My drink's gonna spill without a lid!"
	]
	var noStrawMessages = [
		"There's no straw!",
		"Where's my straw?",
		"I'm missing a straw!"
	]
	var timeOverMessages = [
		"You took a long time to make my order.",
		"This order took forever!",
		"I've been waiting ages for this."
	]
	
	# Initialize the dictionary to track which order items were correctly served
	var orderComponents = {}
	for item in global.order:
		orderComponents[item] = false
	
	for playerItem in global.playerOrder:
		if playerItem in global.order:
			matchingComponents += 1
			orderComponents[playerItem] = true
		else:
			unexpectedItems.append(format_item_name(playerItem))
	
	score = int(float(matchingComponents) / len(global.order) * 100)
	print("initial score, ", score)
	
	if not global.hasLid:
		score -= 15
		issues.append(rand_text(noLidMessages))
	if not global.hasStraw:
		score -= 15
		issues.append(rand_text(noStrawMessages))
	if global.timeOver:
		score -= 20
		issues.append(rand_text(timeOverMessages))
	if matchingComponents < len(global.playerOrder):
		score -= (15 * (len(global.playerOrder) - len(global.order)))
		if unexpectedItems.size() > 0:
			issues.append("I didn't ask for " + format_list(unexpectedItems) + "!")
	
	for item in orderComponents.keys():
		if not orderComponents[item]:
			forgottenItems.append(format_item_name(item))
	
	if forgottenItems.size() > 0:
		issues.append("I didn't get my " + format_list(forgottenItems) + "!")
	
	return {"score": score, "issues": issues}

	
func showDialogue():
	$Notif/Label.visible = true
	var orderCheck = checkOrder()
	var score = orderCheck["score"]
	var issues = orderCheck["issues"]
	var feedbackText = ""
	
	# Define feedback based on the score
	if score == 100:
		feedbackText = "Perfect work! "
	elif score > 80 and score < 100:
		feedbackText = "So close! "
	elif score > 60 and score < 79:
		feedbackText = "It's good, but not exactly what I ordered. "
	elif score > 30 and score < 59:
		feedbackText = "Hm, it seems like my order was messed up. "
	elif score < 29:
		feedbackText = "Ah, this isn't my order! "
	
	# Append issues to the feedback text
	var positiveMessages = [
		"You just made my day!",
		"I'm so excited to drink this!",
		"I love it!"
	]
	if issues.size() > 0:
		feedbackText += " ".join(issues)
	else:
		feedbackText += rand_text(positiveMessages)
	
	$Notif/Label.text = feedbackText
	get_tree().paused = false

func _on_diag_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			$finish.play()
			$Notif/Label.visible = false
			$Notif/Clear.visible = true
			await(get_tree().create_timer(3)).timeout
			$Notif.visible = false
			$Notif/Clear.visible = false
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
