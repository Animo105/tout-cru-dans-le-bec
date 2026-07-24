extends PanelContainer

@onready var format_panel: PanelContainer = %FormatPanel
@onready var user_panel: PanelContainer = %UserPanel
@onready var variety_panel: PanelContainer = %VarietyPanel

var panels : Array[Control] = []

func _ready() -> void:
	panels = [
		format_panel,
		user_panel,
		variety_panel
	]

func hide_all():
	for p in panels:
		p.hide()

func _on_variety_button_pressed() -> void:
	hide_all()
	variety_panel.show()


func _on_fromat_button_pressed() -> void:
	hide_all()
	format_panel.show()


func _on_user_button_pressed() -> void:
	hide_all()
	user_panel.show()
