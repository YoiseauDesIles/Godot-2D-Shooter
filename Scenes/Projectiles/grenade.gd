extends RigidBody2D

const speed = 750
var explosion_active: bool = false
var explosion_radius: int = 400
@export var damage: int = 30

func explode():
	$AnimationPlayer.play("Explosion")
	explosion_active = true
	#$PointLight2D.enabled = true


func _process(_delta):
	if (explosion_active):
		explosion_active = false
		var targets = get_tree().get_nodes_in_group("Containers") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if ("hit" in target and in_range):
				target.hit(damage)


