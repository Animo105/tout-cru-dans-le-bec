extends PanelContainer
class_name ActivityView

signal pressed

const ACTIVITY_VIEW = preload("uid://bpwcrtgac6qwi")

static func instanciate(a : Activity) -> ActivityView:
	var activity_vew : ActivityView = ACTIVITY_VIEW.instantiate()
	activity_vew.activity = a
	return activity_vew

@onready var activity_type_label: Label = $MarginContainer/VBoxContainer/ActivityTypeLabel
@onready var started_by_label: Label = $MarginContainer/VBoxContainer/HFlowContainer/StartedByLabel
@onready var batch_label: Label = $MarginContainer/VBoxContainer/HFlowContainer/BatchLabel

var activity : Activity = null

func _ready() -> void:
	activity_type_label.text = activity.activity_type_as_string()
	started_by_label.text = "Commencé par %s" % activity.started_by_user_name
	batch_label.text = "Lot: %s" % activity.batch_number


func _on_button_pressed() -> void:
	pressed.emit()
