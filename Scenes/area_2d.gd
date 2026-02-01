extends Area2D

# Export allows you to set this to 1 or 2 in the Godot Inspector
@export var mask_id: int = 1 

func _on_body_entered(body):
	print("mask area entered")
	# Check if the object entering the area is the Player
	if body.has_method("collect_mask"):
		body.collect_mask(mask_id)
		# Optional: Play a sound or particle effect here
		queue_free() # Remove the mask from the ground

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
