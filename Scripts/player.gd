extends CharacterBody2D

@export var speed = 5500.0;
var direction : Vector2;
var state = UNMASKED;

# Ability Booleans
var can_talk: bool = false
var can_dash: bool = false

# Mask Inventory Logic
var unlocked_masks = [] # Stores integers: 1 for Talk, 2 for Dash
var current_mask_index: int = -1 # -1 means no mask is active

@onready var mask_timer = $MaskTimer

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
		
		
	#Mask equip logic
	if Input.is_action_just_pressed("mask"):
		Global.can_talk = true;
		#handle_mask_input()
		print("mask equipped");
	
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

func player():
	pass;

func handle_mask_input():
	if unlocked_masks.is_empty():
		return # Requirement 1: Do nothing if no masks are picked up

	# If no mask is active, start the carousel at the first unlocked mask
	if current_mask_index == -1:
		activate_mask(0)
		
	else:
		# Requirement 2 & 3: If we have multiple masks, cycle. If only one, refresh.
		var next_index = (current_mask_index + 1) % unlocked_masks.size()
		activate_mask(next_index)

func activate_mask(index: int):
	current_mask_index = index
	var mask_id = unlocked_masks[current_mask_index]
	
	# Apply Abilities
	apply_mask_effects(mask_id)
	
	# Start or Restart the 5-second timer
	mask_timer.start(5.0)
	print("Active Mask: ", mask_id, " | Time remaining: 5s")

func apply_mask_effects(id: int):
	# Reset all first
	can_talk = false
	can_dash = false
	
	match id:
		1:
			can_talk = true
		2:
			can_dash = true
			
func _on_mask_timer_timeout():
	# Requirement: Remove mask after 5 seconds
	current_mask_index = -1
	can_talk = false
	can_dash = false
	print("Mask expired. Abilities lost.")

# Logic to pick up masks (Call this from your Pickup Area2D)
func collect_mask(id: int):
	if not unlocked_masks.has(id):
		unlocked_masks.append(id)
		unlocked_masks.sort() # Keeps them in order: 1 then 2
