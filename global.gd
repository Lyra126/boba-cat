extends Node

var SomethingBeingClickedRn = false
var prevOrderFinished = false
var order = []
var playerOrder = []
var totalCurrency = 0

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
