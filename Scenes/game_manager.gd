extends Node

@onready var npc_1: Label = $"../Labels/NPC1"

func _ready() -> void:
	npc_1.visible = false;

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if Global.can_talk:
			npc_1.text = "Ok. You may pass";
			npc_1.visible = true;
		else:
			npc_1.text = "YOU SHALL NOT PASS!!!"
			npc_1.visible = true;
