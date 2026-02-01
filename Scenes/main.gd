extends Node2D

var can_player_talk = false;

func _on_npc_check_if_can_talk():
	return can_player_talk;

func mask_timer() -> void:
	pass # Replace with function body.
