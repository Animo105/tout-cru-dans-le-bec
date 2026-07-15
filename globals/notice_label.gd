extends Label
class_name NoticeLabel

var _tween : Tween = null

func _ready() -> void:
	visible = false

const SUCCESS_COLOR : Color = Color.WHITE
const WARNING_COLOR : Color = Color.YELLOW
const ERROR_COLOR : Color = Color.RED

func notice_error(message : String, time_s : float = 5.0) -> void:
	text = message
	set("theme_override_colors/font_color", ERROR_COLOR)
	visible = true
	_set_tween(time_s)

func notice_warning(message : String, time_s : float = 5.0) -> void:
	text = message
	set("theme_override_colors/font_color", WARNING_COLOR)
	visible = true
	_set_tween(time_s)

func notice_success(message : String, time_s : float = 5.0) -> void:
	text = message
	set("theme_override_colors/font_color", SUCCESS_COLOR)
	visible = true
	_set_tween(time_s)

func _set_tween(time_s : float):
	if _tween :
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "visible", false, time_s)
