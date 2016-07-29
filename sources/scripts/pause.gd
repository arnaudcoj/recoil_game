
extends Node2D

var player_focus = 0
onready var panel = get_node("panel")
onready var pause_label = panel.get_node("pause_label")

func _ready():
	set_process_input(true)

func _input(event):
	# if the game is paused
	if get_tree().is_paused():
		# handle inputs of the player having focus
		if event.is_action_pressed("p" + str(player_focus) + "_start"):
			unpause()
	else:
		# pause and give focus to the player who paused
		if event.is_action_pressed("p1_start") && controler.get_players().is_alive(1):
			pause(1)
		elif event.is_action_pressed("p2_start") && controler.get_players().is_alive(2):
			pause(2)
		elif event.is_action_pressed("p3_start") && controler.get_players().is_alive(3):
			pause(3)
		elif event.is_action_pressed("p4_start") && controler.get_players().is_alive(4):
			pause(4)

func pause(player):
	get_tree().set_pause(true)
	player_focus = player
	pause_label.set_text("Pause (" + str(player_focus) + ")")
	show()
	
func unpause():
	get_tree().set_pause(false)
	hide()