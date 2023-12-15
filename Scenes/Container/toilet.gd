extends ItemContainer

func hit(_damage):
	if not opened:
		$AudioStreamPlayer2D.play()
		$LidSprite.hide()
		
		for i in range(15):
			var pos = $SpawnPositions.get_child(randi()%$SpawnPositions.get_child_count()).global_position
			open.emit(pos, current_direction)	
		opened = true
	
