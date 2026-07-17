extends PanelContainer

@onready var format_panel: PanelContainer = $MarginContainer/VBoxContainer/PanelContainer/FormatPanel
@onready var user_panel: PanelContainer = $MarginContainer/VBoxContainer/PanelContainer/UserPanel

var panels : Array[Control] = []

func _ready() -> void:
	panels = [
		format_panel,
		user_panel
	]

func hide_all():
	for p in panels:
		p.hide()

func _on_variety_button_pressed() -> void:
	pass # Replace with function body.


func _on_fromat_button_pressed() -> void:
	hide_all()
	format_panel.show()


func _on_user_button_pressed() -> void:
	hide_all()
	user_panel.show()
