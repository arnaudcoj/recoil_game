
extends Node2D

var enabled = false

var player_focus = 0
onready var panel = get_node("panel")
onready var buttons = panel.get_node("buttons")
onready var pause_label = panel.get_node("pause_label")
onready var cooldown = get_node("cooldown")

const ANALOG_THRESHOLD = 0.75
var analog_cooldown = false

signal restart

func _ready():
	set_process_input(true)

func _input(event):
	if !enabled:
		return
	# if the game is paused
	if is_paused():
		# handle inputs of the player having focus
		# start
		if event.is_action_pressed("p" + str(player_focus) + "_start"):
			press_button()
		# up
		elif event.is_action_pressed("p" + str(player_focus) + "_up"):
			if event.type == InputEvent.JOYSTICK_MOTION:
				if !analog_cooldown && event.value <= - ANALOG_THRESHOLD:
					analog_cooldown = true
					button_up()
			else:
				button_up()
		elif event.is_action_released("p" + str(player_focus) + "_up"):
			analog_cooldown = false
		# down
		elif event.is_action_pressed("p" + str(player_focus) + "_down"):
			if event.type == InputEvent.JOYSTICK_MOTION:
				if !analog_cooldown && event.value >= ANALOG_THRESHOLD:
					analog_cooldown = true
					button_down()
			else:
				button_down()
		elif event.is_action_released("p" + str(player_focus) + "_down"):
			analog_cooldown = false
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

func button_down():
	buttons.set_selected(min(buttons.get_button_count() - 1, buttons.get_selected() +1))

func button_up():
	buttons.set_selected(max(0, buttons.get_selected() -1))

func pause(player):
	get_tree().set_pause(true)
	player_focus = player
	pause_label.set_text("Pause (" + str(player_focus) + ")")
	show()
	
func unpause():
	get_tree().set_pause(false)
	hide()
	enabled = false
	cooldown.start()
	
func is_paused():
	return !is_hidden()

func press_button():
	var button_idx = buttons.get_selected()
	# Resume
	if button_idx == 0:
		unpause()
	# Resume
	if button_idx == 1:
		unpause()
		emit_signal("restart")
	# Player Selection
	elif button_idx == 2:
		unpause()
		controler.get_main().go_to_level_selection()
	# Player Selection
	elif button_idx == 3:
		unpause()
		controler.get_main().go_to_player_selection()
	#Quit
	elif button_idx == 4:
		unpause()
		controler.get_main().go_to_starting_screen()

func _on_cooldown_timeout():
	enabled = true