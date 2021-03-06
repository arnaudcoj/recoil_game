
extends Node

var starting_screen_scn = preload("res://scenes/starting_screen.tscn")
var game_scn = preload("res://scenes/game.tscn")
var player_selection_scn = preload("res://scenes/player_selection.tscn")
var level_selection_scn = preload("res://scenes/level_selection.tscn")

var players
var players_skins
var level

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
	
func go_to_level_selection():
	var level_selection = level_selection_scn.instance()
	level_selection.connect("start", self, "_on_level_selection_start")
	for child in get_children():
		child.queue_free()
	add_child(level_selection)

func start_game():
	var game = game_scn.instance()
	for child in get_children():
		child.queue_free()
	add_child(game)
	game.set_players_list(players, players_skins)
	game.set_level(level)
	game.reset()
	game.start()


func _on_level_selection_start(level):
	self.level = level
	start_game()

func _on_player_selection_start(players, players_skins):
	self.players = players
	self.players_skins = players_skins
	go_to_level_selection()

func _on_starting_screen_start_pressed():
	go_to_player_selection()
