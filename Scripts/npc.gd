extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $Label

var is_chatting = false;


var player;
var player_in_chat_zone = false;

func _ready() -> void:
	randomize();
	label.visible = false;
	
func _process(delta: float) -> void:

			
	if Input.is_action_just_pressed("interact"):
		#check whether the player can talk to the npc (does he have a mask?)
		if Global.can_talk:
			print("chatting with npc");
			print("You may pass!");
			$"../Player/Camera2D/CanvasLayer/Control/VBoxContainer/DialogueBox".start();
			is_chatting = true;
			animated_sprite.play("idle");
			$Barrier.disabled = true;
		else:
			print("YOU SHALL NOT PASS!!!!");
			$Barrier.disabled = false;

func choose(array):
	array.shuffle();
	return array.front();

# player entered chat detection area
func _on_chat_detection_area_body_entered(body: Node2D) -> void:
	#TODO: maybe check to see if the body is the player so that random entities dont trigger this function
	player_in_chat_zone = true;
	print("entered chat zone");
	label.visible = true;

# player exited chat detection area
func _on_chat_detection_area_body_exited(body: Node2D) -> void:
	player_in_chat_zone = false;
	print("exited chat zone");
	label.visible = false;

func _on_dialogue_box_dialogue_finished() -> void:
	is_chatting = false;
	Global.currentDialogue += 1;
	print(Global.currentDialogue);
