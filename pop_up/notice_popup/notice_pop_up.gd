extends CanvasLayer
class_name NoticePopup

signal answered

@onready var _title: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Title

@onready var _text_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Text

func _reset():
	_title.text = "PopUp"
	_text_label.text = ""

func open_popup_with_text(title : String, text : String):
	_title.text = title
	_reset()
	_text_label.text = text
	show()

func _on_confirmer_pressed() -> void:
	hide()
	answered.emit()
