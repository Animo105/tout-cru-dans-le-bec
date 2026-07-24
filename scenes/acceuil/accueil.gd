extends PanelContainer

@onready var activities_list: VBoxContainer = $VBoxContainer/MarginContainer/ScrollContainer/ActivitiesList

func _ready() -> void:
	for a : Activity in Globals.activities:
		var view : ActivityView = ActivityView.instanciate(a)
		activities_list.add_child(view)
		view.pressed.connect(_on_activity_completed.bind(a.id))

func _on_activity_completed(id : int):
	print(id)
