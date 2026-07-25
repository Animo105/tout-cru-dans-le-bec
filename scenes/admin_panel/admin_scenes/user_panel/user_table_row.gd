extends PanelContainer
class_name UserTableRow

var name_label : Label = Label.new()
var is_admin_label : Label = Label.new()

var delete_button : Button = Button.new()
var edit_button : Button = Button.new()

func _init(user : User) -> void:
	name_label.text = user.name
	if user.user_type == User.UserType.SuperUser:
		is_admin_label.text = "Admin"
	else:
		is_admin_label.text = ""
	delete_button.text = "Supprimer"
	edit_button.text = "Modifier"

func remove_row():
	name_label.get_parent().remove_child(name_label)
	is_admin_label.get_parent().remove_child(is_admin_label)
	edit_button.get_parent().remove_child(edit_button)
	delete_button.get_parent().remove_child(delete_button)

func insert_in_grid_container(grid_container : GridContainer):
	grid_container.add_child(name_label)
	grid_container.add_child(is_admin_label)
	grid_container.add_child(edit_button)
	grid_container.add_child(delete_button)
