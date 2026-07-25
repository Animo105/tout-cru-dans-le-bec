extends PanelContainer

@onready var user_name_line_edit: LineEdit = %UserNameLineEdit
@onready var name_line_edit: LineEdit = %NameLineEdit
@onready var password_line_edit: LineEdit = %PasswordLineEdit
@onready var option_button: OptionButton = %OptionButton
@onready var pop_up_user: CanvasLayer = %PopUpUser

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	option_button.add_item("Utilisateur", 0)
	option_button.add_item("Super utilisateur", 1)


func _on_new_user_button_pressed() -> void:
	pop_up_user.show()


func _on_confirmer_pressed() -> void:
	pop_up_user.hide()


func _on_annuler_pressed() -> void:
	pop_up_user.hide()
