extends CharacterBody2D

signal laser(pos, direction)
signal grenade(pos, direction)

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 750
var speed: int = max_speed

func hit(damage):
	Globals.health -= damage

func _process(_delta):
	
	#input
	var direction = Input.get_vector("left","right","up", "down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position
	
	#rotate
	look_at(get_global_mouse_position())
	
	#laser shooting input
	var player_direction = (get_global_mouse_position() - position).normalized()
	if (Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0):
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		# randomly select a marker2D for the laser start
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		
		can_laser = false
		$LaserTimer.start()
		# emit the position we selected
		
		laser.emit(selected_laser.global_position, player_direction)

	if (Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0):
		Globals.grenade_amount -= 1
		var grenade_pos = $LaserStartPositions.get_children()[0].global_position
		can_grenade = false
		$GrenadeTimer.start()
		grenade.emit(grenade_pos, player_direction)

	if (Globals.health <= 0):
		TransitionLayer.change_scene("res://Scenes/Levels/failure.tscn")
		queue_free()
		
	if (Globals.enemies_left <= 0):
		TransitionLayer.change_scene("res://Scenes/Levels/victory.tscn")

func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true


#func add_item(type: String) -> void:
#	if (type == 'laser'):
#		Globals.laser_amount += 5
#	if (type == 'grenade'):
#		Globals.grenade_amount += 2
#	update_stats.emit()
