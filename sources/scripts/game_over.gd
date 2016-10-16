
extends Node2D

onready var panel = get_node("panel")
onready var buttons = panel.get_node("buttons")
onready var winner_label = panel.get_node("winner_label")

const ANALOG_THRESHOLD = 0.75
var analog_cooldown = false

signal restart

func _ready():
	set_process_input(true)

func _input(event):
	# if the game is paused
	if is_activated():
		# handle inputs of the player having focus
		# start
		if event.is_action_pressed("p1_start") or event.is_action_pressed("p2_start") or event.is_action_pressed("p3_start") or event.is_action_pressed("p4_start"):
			press_button()
		# up
		elif event.is_action_pressed("p1_up") or event.is_action_pressed("p2_up") or event.is_action_pressed("p3_up") or event.is_action_pressed("p4_up"):
			if event.type == InputEvent.JOYSTICK_MOTION:
				if !analog_cooldown && event.value <= - ANALOG_THRESHOLD:
					analog_cooldown = true
					button_up()
			else:
				button_up()
		elif event.is_action_released("p1_up") or event.is_action_released("p2_up") or event.is_action_released("p3_up") or event.is_action_released("p4_up"):
			analog_cooldown = false
		# down
		elif event.is_action_pressed("p1_down") or event.is_action_pressed("p2_down") or event.is_action_pressed("p3_down") or event.is_action_pressed("p4_down"):
			if event.type == InputEvent.JOYSTICK_MOTION:
				if !analog_cooldown && event.value >= ANALOG_THRESHOLD:
					analog_cooldown = true
					button_down()
			else:
				button_down()
		elif  event.is_action_pressed("p1_down") or event.is_action_pressed("p2_down") or event.is_action_pressed("p3_down") or event.is_action_pressed("p4_down"):
			analog_cooldown = false

func button_down():
	buttons.set_selected(min(buttons.get_button_count() - 1, buttons.get_selected() +1))

func button_up():
	buttons.set_selected(max(0, buttons.get_selected() -1))

func set_winner(winner):
	if winner:
		winner_label.set_text("PLAYER " + str(winner) + " WON!")

func activate():
	get_tree().set_pause(true)
	show()
	
func deactivate():
	get_tree().set_pause(false)
	winner_label.set_text("DRAW")
	hide()
	
func is_activated():
	return !is_hidden()

func press_button():
	var button_idx = buttons.get_selected()
	# Restart
	if button_idx == 0:
		deactivate()
		emit_signal("restart")
	# Player Selection
	elif button_idx == 1:
		deactivate()
		controler.get_main().go_to_level_selection()
	# Player Selection
	elif button_idx == 2:
		deactivate()
		controler.get_main().go_to_player_selection()
	#Quit
	elif button_idx == 3:
		deactivate()
		controler.get_main().go_to_starting_screen()

