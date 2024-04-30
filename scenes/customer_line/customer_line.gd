extends Node2D

var OrderForm
@onready var progress_bar : TextureProgressBar = $Customer/TextureProgressBar
@onready var canfire = true
@onready var timer = $Customer/Timer
@onready var percentage_of_time
var nextCustomerCalled = false


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
	
func _input(event):

	if get_tree().paused:
		return
	


func _on_next_pressed():
	if global.dialogueCompleted and $Customer/TextureProgressBar.visible:
		get_tree().change_scene_to_file("res://scenes/Toppings/Toppings.tscn")

	
	
func _process(delta):
	if global.order != []:
		$TextureButton.visible = true
		
	if global.dialogueCompleted and not global.orderShown:
		$order.visible = true
		generate_order()
		showOrder()
		global.orderShown = true
		
	if progress_bar.value == 100 and not nextCustomerCalled:
		timer.stop()
		nextCustomerCalled = true
		await get_tree().create_timer(2.0).timeout
		nextCustomer()
	elif timer.get_time_left() > 0:
		percentage_of_time = ((1 - timer.get_time_left() / timer.get_wait_time()) * 100) #100
		progress_bar.value = percentage_of_time
			
		
func nextCustomer():
	$order.visible = false
	progress_bar.visible = false
	progress_bar.value = 0
	global.dialogueCompleted = false
	$order.visible = false;
	$Customer.position.x =  1300
	var randomIndex = randi() % global.allCustomers.size()
	global.currCustomer = global.allCustomers[randomIndex]
	$Customer.texture = global.get_customer_texture(global.currCustomer)
	$Customer.visible = true;
	await get_tree().create_timer(1.0).timeout
	move_customer()
	canfire = true
	nextCustomerCalled = false

func generate_order():
	var drink = drink_options[randi() % drink_options.size()]
	var milk = milk_options[randi() % milk_options.size()]
	var syrup = syrup_options[randi() % syrup_options.size()]
	var topping = topping_options[randi() % topping_options.size()]
	global.order = [topping, drink, milk, syrup]
	
	var num_cookies = randi() % 6
	print("num cookies:", num_cookies)
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
	print(orderText)
	$order/Label.visible = true
	$order/Label.set_text(orderText)

func _on_close_pressed() -> void:
	$order.visible = false
	$order/Label.visible = false
	$close.visible = false
	#start timer
	progress_bar.visible = true
	canfire = false
	timer.start()


func _on_texture_button_pressed() -> void:
	$order.visible = true
	$close.visible = true
	var orderText = ""
	for item in global.order:
		orderText += str(item) + "\n"
	$order/Label.visible = true
	$order/Label.set_text(orderText)
