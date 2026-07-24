extends PanelContainer

@onready var v_box_container: VBoxContainer = $VBoxContainer/MarginContainer/ScrollContainer/VBoxContainer

func _ready() -> void:
	for a : Activity in Globals.activities:
		var view : ActivityView = ActivityView.instanciate(a)
		v_box_container.add_child(view)
