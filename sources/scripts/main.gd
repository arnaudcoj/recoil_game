
extends Node

onready var players = get_node("players")

func _ready():
	pass
	
func _on_players_player_died(player_idx):
	print("player " + str(player_idx) + " diededed")
	if players.get_alive_players_count() < 2 :
		game_over()

func game_over():
	var winner = players.get_first_alive_player_index()
	if winner == 0 :
		print("draw")
	else :
		print("player " + str(winner) + " won !")
	restart()

func restart():
	get_tree().reload_current_scene()