extends PanelContainer

@onready var pop_up: ConfirmPanel = $PopUp
@onready var format_list: VBoxContainer = $MarginContainer/FormatList

var fields : Dictionary[int, Field] = {}

func _ready() -> void:
	for format in Globals.formats:
		new_format_field(format)

func new_format_field(format : Format):
	var field := Field.instantiate()
	field.text_value = format.format
	field.del_pressed.connect(on_delete.bind(format.id))
	field.edit_pressed.connect(on_edit.bind(format.id))
	fields[format.id] = field
	format_list.add_child(field)

func _on_new_format_button_pressed() -> void:
	pop_up.open_popup_with_edit_line("Nouveau Format", "")
	await pop_up.answered
	if pop_up.is_confirmed:
		var format_name : String = pop_up.edit_line_value
		var format : Format = Format.new()
		format.format = format_name
		var res := await HttpHelper.request("/api/formats", HTTPClient.METHOD_POST, format.to_byte_array())
		if res.result != 0:
			ErrorService.display_error("Serveur injoignable.", 5)
			return
		if res.response_code != 200:
			ErrorService.display_error("Erreur du serveur: %s" % res.response_code, 5)
			return
		var response : Dictionary = JSON.parse_string(res.body.get_string_from_utf8())
		var new_format : Format = Format.from_response(response)
		new_format_field(new_format)
		Globals.formats.append(new_format)

func on_delete(id : int):
	prints("Delete", id)

func on_edit(id : int):
	prints("Edit", id)


func _on_variety_button_pressed() -> void:
	pass # Replace with function body.
