extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $Label

const SPEED = 30;
var current_state = IDLE;

var is_roaming = true;
var is_chatting = false;

var direction = Vector2.RIGHT;
var start_pos;

var player;
var player_in_chat_zone = false;

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready() -> void:
	randomize();
	start_pos = position;
	label.visible = false;
	
func _process(delta: float) -> void:
	# handle animations
	if current_state == 0 or current_state == 1:
		animated_sprite.play("idle");
	if current_state == 2 and !is_chatting:
		if direction.x == -1:
			animated_sprite.play("walk_west");
		if direction.x == 1:
			animated_sprite.play("walk_east");
		if direction.y == -1:
			animated_sprite.play("walk_north");
		if direction.y == 1:
			animated_sprite.play("walk_south");

	if is_roaming:
		match current_state:
			IDLE: pass;
			NEW_DIR: 
				direction = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]);
			MOVE:
				move(delta);
			
	if Input.is_action_pressed("interact"):
		print("chatting with npc");
		$DialogueBox.start();
		is_chatting = true;
		is_roaming = false;
		animated_sprite.play("idle");

func choose(array):
	array.shuffle();
	return array.front();
	
func move(delta):
	if !is_chatting:
		position += direction * SPEED * delta;
		
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


func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5, 1, 1.5]);
	current_state = choose([IDLE, NEW_DIR, MOVE]);
	


func _on_dialogue_box_dialogue_finished() -> void:
	is_chatting = false;
	is_roaming = true;
