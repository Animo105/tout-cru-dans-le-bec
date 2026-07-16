extends HBoxContainer
class_name Field

const FIELD = preload("uid://b5kw1d6r8tm0e")

static func instantiate() -> Field:
	return FIELD.instantiate()
	

@onready var label: Label = $Label
var text_value : String = "" : set = _set_text

func _set_text(v : String):
	text_value = v
	if label: label.text = v

func _ready() -> void:
	label.text = text_value

signal edit_pressed
signal del_pressed

func _on_edit_button_pressed():
	edit_pressed.emit()

func _on_del_button_pressed():
	del_pressed.emit()
