
extends Node

var game_scn = preload("res://scenes/game.tscn")

func _ready():
	pass
	
func start_game(players):
	var game = game_scn.instance()
	add_child(game)
	game.set_players_list(players)
	game.start()
	

func _on_player_selection_start(players):
	start_game(players)