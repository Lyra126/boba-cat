extends Node

var SomethingBeingClickedRn = false
var prevOrderFinished = false
var currOrderFinished = false
var currCustomer = "cat1"
var allCustomers = ["cat1", "cat2", "cat3", "cat4", "cat5", "cat6", "cat7", "cat8", "cat9", "cat10"]
var visitedCustomers = []
var cat1 = preload("res://assets/cat1.png")
var cat2 = preload("res://assets/cat2.png")
var cat3 = preload("res://assets/cat3.png")
var cat4 = preload("res://assets/cat4.png")
var cat5 = preload("res://assets/cat5.png")
var cat6 = preload("res://assets/cat6.png")
var cat7 = preload("res://assets/cat7.png")
var cat8 = preload("res://assets/cat8.png")
var cat9 = preload("res://assets/cat9.png")
var cat10 = preload("res://assets/cat10.png")
var dialogueCompleted = false
var order = []
var playerOrder = []
var totalCurrency = 0


func get_customer_texture(customer):
	match customer:
		"cat1":
			return cat1
		"cat2":
			return cat2
		"cat3":
			return cat3
		"cat4":
			return cat4
		"cat5":
			return cat5
		"cat6":
			return cat6
		"cat7":
			return cat7
		"cat8":
			return cat8
		"cat9":
			return cat9
		"cat10":
			return cat10
	return null

var toppings_inserted = []
var liquids_poured = []
var syrups_poured = []
var desserts_picked = []

# should finalize the playerOrder before comparing it with order array
# 0 index: toppings
# 1 index: liquids (milk and tea)
# 2 index: syrups
# 3 index: desserts
#func finalized_player_cup():
	#playerOrder.append(toppings_inserted)
	#playerOrder.append(liquids_poured)
	#playerOrder.append(syrups_poured)
	#playerOrder.append(desserts_picked)
>>>>>>> Stashed changes
