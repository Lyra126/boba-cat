extends Node2D

var OrderForm
@onready var progress_bar : TextureProgressBar = $Customer/TextureProgressBar
@onready var canfire = true
@onready var percentage_of_time


var drink_options = ["tea", "coffee", "smoothie"]
var syrup_options = ["sugar-25", "sugar-50", "sugar-75", "sugar-100"]
var milk_options = ["oat-milk", "almond-milk", "cow-milk"]
var topping_options = ["boba", "popping-boba", "dalgona-chunks", "fruit-jelly", "strawberries"]
var cookie_options = ["chocolate-cookie", "sugar-cookie", "cat-cookie"]

# Called when the node enters the scene tree for the first time.
func _ready():
	var randomIndex = randi() % global.allCustomers.size()
	global.currCustomer = global.allCustomers[randomIndex]
	$Customer.texture = global.get_customer_texture(global.currCustomer)
	$Next.pressed.connect(self._on_next_pressed)
	$order.visible = false
	global.dialogueCompleted = false
	progress_bar.visible = false
	progress_bar.value = 0
	canfire = true
	percentage_of_time = 0
	
func _input(event):
	if get_tree().paused:
		return
		
func _on_next_pressed():
	if global.dialogueCompleted and $Customer/TextureProgressBar.visible:
		$button.play()
		get_tree().change_scene_to_file("res://scenes/Toppings/Toppings.tscn")
		
func _process(delta):
	if global.order != []:
		$TextureButton.visible = true
		
	if global.dialogueCompleted and not global.orderShown:
		$order.visible = true
		generate_order()
		showOrder()
		global.orderShown = true
		
	if global.timerInProgress:
		percentage_of_time = ((global.mins * 60) + global.secs) / 90.0
		progress_bar.value = percentage_of_time * 100
			
	
func generate_order():
	var drink = drink_options[randi() % drink_options.size()]
	var milk = milk_options[randi() % milk_options.size()]
	var syrup = syrup_options[randi() % syrup_options.size()]
	var topping = topping_options[randi() % topping_options.size()]
	global.order = [topping, drink, milk, syrup]
	
	var num_cookies = randi() % 6
	for i in range(num_cookies):
		var cookie = cookie_options[randi() % cookie_options.size()]
		global.order.append(cookie)
	print(global.order)
	
func showOrder():
	$order.visible = true
	$close.visible = true
	var orderText = ""
	for item in global.order:
		orderText += str(item) + "\n"
	$order/Label.visible = true
	$order/Label.set_text(orderText)

func _on_close_pressed() -> void:
	$button.play()
	$order.visible = false
	$order/Label.visible = false
	$close.visible = false
	#start timer
	progress_bar.visible = true
	canfire = false
	print("timer start")
	global.timerInProgress = true


func _on_texture_button_pressed() -> void:
	$button.play()
	$order.visible = true
	$close.visible = true
	var orderText = ""
	for item in global.order:
		orderText += str(item) + "\n"
	$order/Label.visible = true
	$order/Label.set_text(orderText)
