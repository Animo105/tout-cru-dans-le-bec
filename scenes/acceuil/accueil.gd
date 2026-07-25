extends PanelContainer

@onready var activities_list: VBoxContainer = %ActivitiesList
@onready var pop_up: ConfirmPanel = $PopUp
@onready var notice_pop_up: NoticePopup = $NoticePopUp

var activity_views : Dictionary[int, ActivityView] = {}

func _ready() -> void:
	for a : Activity in Globals.activities:
		if a.activity_status == Activity.ActivityStatus.Completed:
			continue
		var view : ActivityView = ActivityView.instanciate(a)
		activities_list.add_child(view)
		activity_views[a.id] = view
		view.pressed.connect(_on_activity_completed.bind(a.id))
		

func _on_activity_completed(id : int):
	pop_up.open_popup_with_text("Complété l'activitée", "Voulez vous complété l'activitée?")
	await pop_up.answered
	if not pop_up.is_confirmed: return
	var res = await HttpHelper.request("/api/activity/complete/%s" % id, HTTPClient.METHOD_POST)
	if res.result != 0:
		ErrorService.display_error("Serveur injoignable")
	if res.response_code != 200:
		ErrorService.display_error("Erreur %s" % res.response_code)
	notice_pop_up.open_popup_with_text("Complété l'activitée", "Activité complété")
	activity_views[id].queue_free()
	activity_views.erase(id)
	
