extends Area2D

@export var speed: int = 1000
@export var damages: int = 10
var direction


func _ready():
	$SelfDestructTimer.start()


func _process(delta):
	position += speed * direction * delta


func _on_body_entered(body):
	if ("hit" in body):
		body.hit(damages)
	
	queue_free()
		


func _on_timer_timeout():
	queue_free()
