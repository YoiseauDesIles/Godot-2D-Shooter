extends Node2D

class_name LevelParent

var laser_scene: PackedScene = preload("res://Scenes/Projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://Scenes/Projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://Scenes/Items/item.tscn")

func _ready():
	for container in get_tree().get_nodes_in_group('Containers'):
		container.connect("open", _on_container_opened)
	for scout in get_tree().get_nodes_in_group("Scouts"):
		scout.connect("laser", _on_scout_laser)
		

	

func _on_container_opened(pos, direction):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred('add_child', item)
	

func create_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos	
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	#3. add the laser instance to a node2D
	$Projectiles.add_child(laser)
	#$UI.update_laser_text()

func _on_player_laser(pos, direction):
	create_laser(pos, direction)
	
func _on_scout_laser(pos, direction):
	create_laser(pos, direction)
	
func _on_player_grenade(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
	#$UI.update_grenade_text()
	
	

#func _on_player_update_stats():
	#$UI.update_laser_text()
	#$UI.update_grenade_text()
