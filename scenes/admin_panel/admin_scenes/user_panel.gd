extends PanelContainer

@onready var user_name_line_edit: LineEdit = $CanvasLayer/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/UserNameLineEdit
@onready var name_line_edit: LineEdit = $CanvasLayer/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/NameLineEdit
@onready var password_line_edit: LineEdit = $CanvasLayer/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/PasswordLineEdit
@onready var option_button: OptionButton = $CanvasLayer/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/OptionButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	option_button.add_item("Utilisateur", 0)
	option_button.add_item("Super utilisateur", 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
