tool
extends Node

signal save_animations
signal import_animations
signal load_animations

var animations_loaded

func _ready():
	animations_loaded = get_node("Animations Loaded")
	animations_loaded.color = Color(0.3,0,0)
	animations_loaded.get_node("Label").text = "Animations not loaded! Load or Save animations in AnimationPlayer!"

func animations_load_ok(color, text):
	animations_loaded.color = color
	animations_loaded.get_node("Label").text = text



func _on_import_button_down():
	emit_signal("import_animations")



func _on_save_button_down():
	emit_signal("save_animations")



func _on_load_button_down():
	emit_signal("load_animations")
