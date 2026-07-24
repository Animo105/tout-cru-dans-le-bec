extends PanelContainer
class_name ActivityFullView

const ACTIVITY_FULL_VIEW = preload("uid://dvym5yaydvkkp")

@onready var activity_type_label: Label = $MarginContainer/VBoxContainer/ActivityTypeLabel
@onready var user_label: Label = $MarginContainer/VBoxContainer/UserLabel
@onready var date_label: Label = $MarginContainer/VBoxContainer/DateLabel
@onready var batch_label: Label = $MarginContainer/VBoxContainer/BatchLabel

static func instanciate(a : Activity) -> ActivityFullView:
	var av : ActivityFullView = ACTIVITY_FULL_VIEW.instantiate()
	av.activity = a
	return av

var activity : Activity

func _ready() -> void:
	activity_type_label.text = "%s (%s)" % [activity.activity_type_as_string(), activity.activity_status_as_string()]
	user_label.text = "Commencé par: %s, complété par: %s" % [activity.started_by_user_name, activity.completed_by_user_name]
	batch_label.text = activity.batch_number
	date_label.text = "%s - %s" % [activity.started_date, activity.completed_date]
	
