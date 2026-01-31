extends CanvasLayer

@export_file("*json") var scene_text_file;

var scene_text = {};
var selected_text = [];
var in_progress = false;

@onready var background = $Background;
@onready var text_label: Label = $TextLabel; 

func _ready() -> void:
	background.visible = false;
	scene_text = load_scene_text();
	SignalBus.display_dialog.emit("on_display_dialog")
	


func load_scene_text():
	var file = FileAccess.open(scene_text_file, FileAccess.READ)
	if file:
		return JSON.parse_string(file.get_as_text())
	return {}
