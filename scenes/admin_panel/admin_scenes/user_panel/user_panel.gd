extends PanelContainer

@onready var user_name_line_edit: LineEdit = %UserNameLineEdit
@onready var name_line_edit: LineEdit = %NameLineEdit
@onready var password_line_edit: LineEdit = %PasswordLineEdit
@onready var option_button: OptionButton = %OptionButton
@onready var pop_up_user: CanvasLayer = %PopUpUser
@onready var user_table: GridContainer = %UserTable

var table_rows : Dictionary[int, UserTableRow] = {} #userid, row

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	option_button.add_item("Utilisateur", 0)
	option_button.add_item("Super utilisateur", 1)
	
	
	# ajoute les users
	for user : User in Globals.users:
		var row = UserTableRow.new(user)
		row.insert_in_grid_container(user_table)
		row.delete_button.pressed.connect(_on_delete_user_pressed.bind(user.id))
		row.edit_button.pressed.connect(_on_edit_user_pressed.bind(user.id))
		table_rows[user.id] = row

func _on_edit_user_pressed(id : int):
	var row = table_rows[id]
	var user = Globals.get_user_by_id(id)

func _on_delete_user_pressed(id : int):
	table_rows[id].remove_row()
	table_rows.erase(id)
	var user = Globals.get_user_by_id(id)

func _on_new_user_button_pressed() -> void:
	pop_up_user.show()


func _on_confirmer_pressed() -> void:
	pop_up_user.hide()


func _on_annuler_pressed() -> void:
	pop_up_user.hide()
