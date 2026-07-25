extends CanvasLayer
class_name ConfirmPanel

signal answered

var is_confirmed : bool
var edit_line_value : String : 
	get():
		return _edit_line.text

@onready var _title: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Title

@onready var _edit_line: LineEdit = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Edit
@onready var _text_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Text

func _reset():
	_title.text = "PopUp"
	_text_label.text = ""
	_text_label.hide()
	_edit_line.hide()
	_edit_line.text = ""

func open_popup_with_text(title : String, text : String):
	_title.text = title
	_reset()
	_text_label.text = text
	_text_label.show()
	show()

func open_popup_with_edit_line(title : String, value : String):
	_title.text = title
	_reset()
	_edit_line.text = value
	_edit_line.show()
	show()


func _on_confirmer_pressed() -> void:
	hide()
	is_confirmed = true
	answered.emit()


func _on_annuler_pressed() -> void:
	hide()
	is_confirmed = false
	answered.emit()
