extends Node2D

var can_player_talk = false;

func _ready() -> void:
	Global.currentDialogue = 1;

func _on_npc_check_if_can_talk():
	return can_player_talk;
