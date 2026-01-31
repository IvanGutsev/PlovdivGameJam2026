extends CharacterBody2D

@export var speed = 5500.0;
var direction : Vector2;
var state = UNMASKED;

enum {
	UNMASKED,
	MASKED
}

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("up"):
		direction.y = -1;
	elif Input.is_action_pressed("down"):
		direction.y = 1;	
	else:
		direction.y = 0;
		
	if Input.is_action_pressed("right"):
		direction.x = 1;
	elif Input.is_action_pressed("left"):
		direction.x = -1;
	else:
		direction.x = 0;
		
	# check if there is movement and set the animation to "run"
	if direction:
		if direction.y < 0:
			animated_sprite.play("up");
		if direction.y > 0:
			animated_sprite.play("down");
	else:
		animated_sprite.play("idle");
		
	# handle flipping the sprite as the direction changes
	if direction.x > 0:
		animated_sprite.flip_h = false;
	elif direction.x < 0:
		animated_sprite.flip_h = true;
		
		
	
	##Manage state (masked and unmasked)
	#if Input.is_action_just_pressed("mask and unmask"):
		### if you are unmasked and press the button to put on the mask
		#if state == UNMASKED:
			#state = MASKED;
			#speed = 10000;
			#print("Masked");
		#elif state == MASKED:
			#state = UNMASKED;
			#speed = 5500;
			#print("Unmasked");
			
			
		
	#if Input.is_action_just_pressed("mask and unmask")
		
	direction = direction.normalized();
	velocity = direction * speed * delta;
	move_and_slide();


func _on_mask_take_mask() -> void:
	Global.can_talk = true;
	print("mask taken");
