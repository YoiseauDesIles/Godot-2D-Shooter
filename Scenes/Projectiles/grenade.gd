extends RigidBody2D

const speed = 750

func explode():
	$AnimationPlayer.play("Explosion")
	$PointLight2D.enabled = true
	$RedLightTimer.start()


func _on_red_light_timer_timeout():
	$PointLight2D.enabled = false

