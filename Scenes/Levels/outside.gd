extends LevelParent

func _on_gate_player_entered_gate(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	TransitionLayer.change_scene("res://Scenes/Levels/inside.tscn")



func _on_house_player_entered():
	var tween = get_tree().create_tween()
	#tween.set_parallel(true)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1), 1 ).set_trans(Tween.TRANS_QUAD)
	#tween.tween_property($Player, "modulate:a", 0, 2).from(0.5)


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6,0.6), 2 )


