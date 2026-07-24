extends PanelContainer

@onready var activities_list: VBoxContainer = $VBoxContainer/MarginContainer/ScrollContainer/ActivitiesList

var activity_views : Dictionary[int, ActivityView] = {}

func _ready() -> void:
	for a : Activity in Globals.activities:
		if a.activity_status == Activity.ActivityStatus.Completed:
			continue
		var view : ActivityView = ActivityView.instanciate(a)
		activities_list.add_child(view)
		view.pressed.connect(_on_activity_completed.bind(a.id))
		

func _on_activity_completed(id : int):
	var res = await HttpHelper.request("/api/activity/complete/%s" % id, HTTPClient.METHOD_POST)
	if res.result != 0:
		ErrorService.display_error("")
