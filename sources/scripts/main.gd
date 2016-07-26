
extends Node

onready var players = get_node("players")

func _ready():
	print(players.get_child_count())
	pass
	
func _on_players_player_died():
	if players.nb_players < 2 :
		game_over()

func game_over():
	restart()

func restart():
	get_tree().reload_current_scene()