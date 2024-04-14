extends Node2D

var boba_options = ["Regular Boba"]
var drink_options = ["Tea", "Coffee", "Juice"]
var syrup_options = ["25% Sugar", "50% Sugar", "75% Sugar"]
var milk_options = ["Oat Milk", "Almond Milk", "Regular Milk"]
var topping_options = ["Popping Boba Pearls", "Dalgona Chunks", "Fruit Jelly"]



# Called when the node enters the scene tree for the first time.
func _ready():
	generate_order()
	showOrder()	


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
	var orderText = ""
	for item in global.order:
		orderText += str(item) + "\n"
	print(orderText)
	$Label.set_text(orderText)
