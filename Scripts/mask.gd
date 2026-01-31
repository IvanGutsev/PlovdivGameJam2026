extends Area2D

signal take_mask;

func _on_body_entered(body: Node2D) -> void:
	queue_free();
	take_mask.emit();
