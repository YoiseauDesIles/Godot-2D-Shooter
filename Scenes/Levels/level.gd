extends Node2D

var laser_scene: PackedScene = preload("res://Scenes/Projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://Scenes/Projectiles/grenade.tscn")

func _on_gate_player_entered_gate(body):
	print("player has entered the gate")
	print(body)


func _on_player_laser(pos):
	var laser = laser_scene.instantiate()
	laser.position = pos	
	
	#3. add the laser instance to a node2D
	$Projectiles.add_child(laser)
	
func _on_player_grenade(pos):
	var grenade = grenade_scene.instantiate()
	grenade.position = pos
	$Projectiles.add_child(grenade)
	
	
