extends Node2D

var OrderForm
@onready var progress_bar : TextureProgressBar = $Customer/TextureProgressBar
@onready var canfire = true
@onready var timer = $Customer/Timer
@onready var percentage_of_time
var nextCustomerCalled = false

var boba_options = ["Regular Boba"]
var drink_options = ["Tea", "Coffee", "Juice"]
var syrup_options = ["25% Sugar", "50% Sugar", "75% Sugar"]
var milk_options = ["Oat Milk", "Almond Milk", "Regular Milk"]
var topping_options = ["Popping Boba Pearls", "Dalgona Chunks", "Fruit Jelly"]


# Called when the node enters the scene tree for the first time.
func _ready():
	$Next.pressed.connect(self._on_next_pressed)
	get_tree().paused = true
	await get_tree().create_timer(1.0).timeout
	move_customer()
	get_tree().paused = false
	
func _input(event):

	if get_tree().paused:
		return
	

func move_customer():
	# Define the initial position and the target position
	var initial_position = $Customer.position
	var target_position = Vector2(0, 0) 
	var distance = initial_position.distance_to(target_position)
	var speed = distance * 0.1
	$Customer.position = lerp(initial_position, target_position, min(1.0, speed * get_process_delta_time()))




func _on_next_pressed():
	get_tree().change_scene_to_file("res://scenes/Toppings/Toppings.tscn")

	
	
func _process(delta):
	if global.order != []:
		$TextureButton.visible = true
		
	if global.dialogueCompleted:
		$order.visible = true
		generate_order()
		showOrder()
		global.dialogueCompleted = false
		
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
	var boba = boba_options[randi() % boba_options.size()]
	var drink = drink_options[randi() % drink_options.size()]
	var syrup = syrup_options[randi() % syrup_options.size()]
	var milk = milk_options[randi() % milk_options.size()]
	var topping = topping_options[randi() % topping_options.size()]

	global.order = [boba, drink, syrup, milk, topping]
	# Print the order (you can replace this with your order processing logic)
	print("Customer ordered:", boba, drink, syrup, milk, "with", topping)
	
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
	print(orderText)
	$order/Label.visible = true
	$order/Label.set_text(orderText)
