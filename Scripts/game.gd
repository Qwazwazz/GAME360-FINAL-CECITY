class_name Game extends Resource



var kills: = 0 :
	set(value):
		var previous_kills = kills
		kills = value
		if kills != previous_kills: 
			kills_changed.emit()
		_process_kill_logic()

signal game_started()

signal entered_menu()

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
		
		display_arrow()
		print("Area Cleared")
		
		if areas_cleared == 4:
			display_kills()

func entered_game_menu() -> void:
	entered_menu.emit()

func first_area_start() -> void:
	game_started.emit()

func boss_fight_start() -> void:
	boss_fight.emit()

func display_arrow() -> void:
	area_cleared.emit()

func reset_ui_kills() -> void:
	reset_kills.emit()

func display_kills() -> void:
	show_final_kills.emit()
