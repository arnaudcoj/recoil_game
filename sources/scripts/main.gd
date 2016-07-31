
extends Node

var starting_screen_scn = preload("res://scenes/starting_screen.tscn")
var game_scn = preload("res://scenes/game.tscn")
var player_selection_scn = preload("res://scenes/player_selection.tscn")

func _ready():
	go_to_starting_screen()
	
func go_to_starting_screen():
	var starting_screen = starting_screen_scn.instance()
	starting_screen.connect("start_pressed", self, "_on_starting_screen_start_pressed")
	for child in get_children():
		child.queue_free()
	add_child(starting_screen)
	
func go_to_player_selection():
	var player_selection = player_selection_scn.instance()
	player_selection.connect("start", self, "_on_player_selection_start")
	for child in get_children():
		child.queue_free()
	add_child(player_selection)
	
func start_game(players, players_skins):
	var game = game_scn.instance()
	for child in get_children():
		child.queue_free()
	add_child(game)
	game.set_players_list(players, players_skins)
	game.start()

func _on_player_selection_start(players, players_skins):
	start_game(players, players_skins)

func _on_starting_screen_start_pressed():
	go_to_player_selection()
