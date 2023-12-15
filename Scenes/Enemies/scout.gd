extends CharacterBody2D

signal laser(pos, direction)

var player_nearby : bool = false
var can_laser: bool = true
var right_gun_use = true

var vulnerable: bool = true
@export var health: int = 30

func _process(_delta):
	
	if (player_nearby):
		look_at(Globals.player_pos)
		if (can_laser):
			var marker_node = $LaserSpawnPositions.get_child(right_gun_use)
			right_gun_use = not right_gun_use
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Globals.player_pos - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$Timers/LaserTimer.start()

func hit(damages):
	if (vulnerable):
		health -= damages
		vulnerable = false
		$Timers/HitTimer.start()
		$Sprite2D.material.set_shader_parameter("u_progress", 1)
		$HitSound.play()
	if (health <= 0):
		Globals.enemies_left -= 1
		queue_free()

func _on_attack_area_body_entered(_body):
	player_nearby = true


func _on_attack_area_body_exited(_body):
	player_nearby = false


func _on_laser_timer_timeout():
	can_laser = true


func _on_hit_timer_timeout():
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("u_progress", 0)
	
