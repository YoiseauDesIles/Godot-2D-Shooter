extends CharacterBody2D

var player_scene: PackedScene = preload("res://Scenes/Player/player.tscn")

@export var max_speed: int = 1000
var active: bool = false
var vulnerable: bool = true
var speed : int = 0
var speed_multiplier: int = 1

var explosion_active: bool = false
@export var health: int = 50
@export var attack_damages = 30


func _ready():
	$Explosion.hide()
	$Sprite2D.show()
	$CollisionShape2D.disabled = false
	
func _process(delta):
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed * speed_multiplier
		var collision = move_and_collide(velocity * delta)
		if (collision and collision.get_collider().is_in_group("Player")):
			$AnimationPlayer.play("Explosion")
			explosion_active = true
	if explosion_active:
		explosion_active = false
		var targets = get_tree().get_nodes_in_group("Containers") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < 400
			if in_range and "hit" in target:
				target.hit(attack_damages)
				

func hit(damage):
	if vulnerable:
		health -= damage
		vulnerable = false
		$HitTimer.start()
		$Sprite2D.material.set_shader_parameter("u_progress", 1)
	if health <= 0:
		$AnimationPlayer.play("Explosion")
		explosion_active = true

func stop_movement():
	speed_multiplier = 0


func _on_notice_area_body_entered(_body):
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 6).from(500)


func _on_hit_timer_timeout():
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("u_progress", 0)
