class_name Game extends Resource



var kills: = 0 :
	set(value):
		var previous_kills = kills
		kills = value
		if kills != previous_kills: 
			kills_changed.emit()
		_process_kill_logic()

signal kills_changed()

signal area_cleared()

signal reset_kills()
signal show_final_kills()

signal boss_fight()

var areas_cleared : = 0  

func _process_kill_logic() -> void:
	# When kills reaches 15
	if kills >= 15:
		areas_cleared += 1

		# Only reset on 1st and 2nd time
		if areas_cleared < 3:
			kills = 0
		
		area_cleared.emit()
		print("Area Cleared")
		
		if areas_cleared == 3:
			boss_fight.emit()
		
		if areas_cleared == 4:
			show_final_kills.emit()

func reset_ui_kills() -> void:
	reset_kills.emit()
