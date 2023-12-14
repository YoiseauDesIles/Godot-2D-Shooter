extends CharacterBody2D

var active: bool = false
var player_nearby: bool = false
var vulnerable: bool = true
@export var speed : int = 400
@export var health: int = 100
@export var damages: int = 20

	
func _process(delta):
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
	$NavigationAgent2D.target_position = Globals.player_pos
	
func _physics_process(_delta):
	if active:
		var next_path_position : Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_position - global_position).normalized()
		velocity = direction * speed
		
		if not player_nearby:
			move_and_slide()
		
			var look_angle = direction.angle()
			rotation = look_angle + PI / 2

func _on_notice_area_body_entered(body):
	if body.is_in_group("Player"):
		active = true
		$AnimationPlayer.play("walk")

func _on_notice_area_body_exited(body):
	if body.is_in_group("Player"):
		active = false
		$AnimationPlayer.stop()
	


func _on_navigation_timer_timeout():
	if active:
		$NavigationAgent2D.target_position = Globals.player_pos


func _on_attack_area_body_entered(body):
	if body.is_in_group("Player"):
		player_nearby = true
		$AnimationPlayer.pause()
		$AnimationPlayer.play("attack")


func _on_attack_area_body_exited(body):
	if body.is_in_group("Player"):
		player_nearby = false
		await get_tree().create_timer(0.7).timeout
		$AnimationPlayer.stop()
		$AnimationPlayer.play("walk")


func attack():
	if player_nearby:
		Globals.health -= damages

func hit(damages):
	if vulnerable:
		vulnerable = false
		health -= damages
		$Timers/HitTimer.start()
	if health <= 0:
		queue_free()

func _on_hit_timer_timeout():
	vulnerable = true
		
