extends Area2D

@export var rotation_speed: int = 3
var available_options = ['laser','laser','laser','laser', 'grenade', 'health']
var type = available_options[randi() % len(available_options)]

var direction: Vector2
var distance: int = randi_range(150, 450)

func _ready():
	if (type == 'laser'):
		$Sprite2D.modulate = Color(0.1,0.2,0.6)
	if (type == 'grenade'):
		$Sprite2D.modulate = Color(0.8,0.2,0.1)
	if (type == 'health'):
		$Sprite2D.modulate = Color(0.1,0.8,0.1)
	
	#tween
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.3)
	tween.tween_property(self, "scale", Vector2(1,1), 0.3).from(Vector2(0,0))
	
func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(body):

	#body.add_item(type)
	if (type == 'laser'):
		Globals.laser_amount += 5
	if (type == 'grenade'):
		Globals.grenade_amount += 2
	if (type == 'health'):
		Globals.health += 10
		
	$AudioStreamPlayer2D.play()
	$Sprite2D.hide()
	await $AudioStreamPlayer2D.finished
	queue_free()
