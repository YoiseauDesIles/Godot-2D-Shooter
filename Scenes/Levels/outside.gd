extends LevelParent

func _on_gate_player_entered_gate(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	TransitionLayer.change_scene("res://Scenes/Levels/inside.tscn")



func _on_house_player_entered():
	#$Ground/House/DirectionalLight2D.enabled = true
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.5,0.5), 1 ).set_trans(Tween.TRANS_QUAD)
	tween.tween_property($DirectionalLight2D, "energy", 0.8, 2)
	


func _on_house_player_exited():
	#$Ground/House/DirectionalLight2D.enabled = false
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.3,0.3), 2 )
	tween.tween_property($DirectionalLight2D, "energy", 0.3, 2)


