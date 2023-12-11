extends CharacterBody2D

@export var speed: int = 400

var player_noticed : bool = false
var player_nearby: bool = false
var can_bite: bool = true

var vulnerable: bool = true
var health: int = 30

func _process(_delta):
	var direction: Vector2 = (Globals.player_pos - position).normalized()
	velocity = direction * speed
		
	if (player_noticed):
		move_and_slide()
		look_at(Globals.player_pos)
			

func hit():
	if (vulnerable):
		health -= 10
		vulnerable = false
		$Timers/HitTimer.start()
		$AnimatedSprite2D.material.set_shader_parameter("u_progress", 0.9)
		$Particules/HitParticles.emitting = true
	if (health <= 0):
		await get_tree().create_timer(0.4).timeout
		queue_free()




func _on_notice_area_2d_body_entered(_body):
	player_noticed = true
	$AnimatedSprite2D.play("walk")

func _on_notice_area_2d_body_exited(_body):
	player_noticed = false
	$AnimatedSprite2D.stop()
	
func _on_attack_area_2d_body_entered(_body):
	player_nearby = true
	$AnimatedSprite2D.play("attack")

func _on_attack_area_2d_body_exited(_body):
	player_nearby = false


func _on_hit_timer_timeout():
	vulnerable = true
	$AnimatedSprite2D.material.set_shader_parameter("u_progress", 0)

func _on_attack_cooldown_timeout():
	can_bite = true
	$AnimatedSprite2D.play("attack")


func _on_animated_sprite_2d_animation_finished():
	if (player_nearby):
		Globals.health -= 10
		$Timers/AttackCooldown.start()
