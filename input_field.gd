extends HBoxContainer
class_name InputField

@export var number_only : bool = false

@onready var line_edit: LineEdit = $LineEdit

var label : Label = Label.new()

var input : Variant

func _set_number_only(value : bool):
	number_only = value

func _ready() -> void:
	line_edit.grab_focus()
