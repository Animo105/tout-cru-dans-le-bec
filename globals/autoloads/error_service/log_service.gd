extends CanvasLayer

@onready var label: Label = $PanelContainer/Label
@onready var panel_container: PanelContainer = $PanelContainer
@onready var timer: Timer = $Timer

func display_error(text : String, time_s : float = 5):
	label.text = text
	panel_container.show()
	timer.start(time_s)

func _on_timer_timeout() -> void:
	panel_container.hide()
