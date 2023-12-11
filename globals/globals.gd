extends Node

signal stat_change


var laser_amount = 20:
	#get:
	#	return laser_amount
	set(value):
		laser_amount = value
		stat_change.emit()
	
var grenade_amount = 5:
	#get:
	#	return grenade_amount
	set(value):
		grenade_amount = value
		stat_change.emit()

var player_vulnerable: bool = true
var health = 60: 
	#not useful
	#get:
	#	return health
	set(value):
		#pickup health item
		if (value > health):
			health = min(value, 100)
		else:
			if player_vulnerable:
				health = value
				player_vulnerable = false
				player_invunerable_timer()
				
		stat_change.emit()

#Create a timer in script
func player_invunerable_timer():
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true

var player_pos : Vector2
