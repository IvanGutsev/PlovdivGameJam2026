extends Control

signal dialogue_finished;

@export_file("*.json") var d_file

@onready var nine_patch_rect: NinePatchRect = $NinePatchRect
@onready var name_text: RichTextLabel = $NinePatchRect/Name
@onready var dialogue_text: RichTextLabel = $NinePatchRect/Text

var dialogue = []
var current_dialogue_id = 0;
var dialogue_active = false;

func _ready() -> void:
	nine_patch_rect.visible = false;
	
func start():
	if dialogue_active:
		return;
	dialogue_active = true;
	nine_patch_rect.visible = true;
	dialogue = load_dialogue();
	current_dialogue_id = -1;
	next_script();
	
func load_dialogue():
	var file = FileAccess.open("res://Dialogue/player_dialogue1.json", FileAccess.READ);
	var content = JSON.parse_string(file.get_as_text());
	return content;

func _input(event):
	if !dialogue_active:
		return;
	if event.is_action_pressed("ui_accept"):
		next_script();

func next_script():
	current_dialogue_id += 1;
	if current_dialogue_id >= len(dialogue):
		dialogue_active = false;
		nine_patch_rect.visible = false;
		emit_signal("dialogue_finished");
		return;
		
	name_text.text = dialogue[current_dialogue_id]['name'];
	dialogue_text.text = dialogue[current_dialogue_id]['text'];
	
	
	
	
	
	
	
	
