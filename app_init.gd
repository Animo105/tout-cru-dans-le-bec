extends Control

const FILE_IP_PATH = "user://ip.txt"

#app stuff
@onready var url_textline: LineEdit = $UrlOption/MarginContainer/IP/UrlTextline
@onready var url_option_panel: PanelContainer = $UrlOption
@onready var error_app_label: NoticeLabel = $ErrorAppLabel
@onready var url_option_button: Button = $Button



# login stuff
@onready var username_line_edit: LineEdit = $Login/PanelContainer/MarginContainer/VBoxContainer/UsernameLineEdit
@onready var mot_de_passe_line_edit: LineEdit = $Login/PanelContainer/MarginContainer/VBoxContainer/MotDePasseLineEdit
@onready var login_button: Button = $Login/PanelContainer/MarginContainer/VBoxContainer/LoginButton
@onready var error_login_label: Label = $Login/PanelContainer/MarginContainer/VBoxContainer/ErrorMsg
@onready var panel_container: PanelContainer = $Login/PanelContainer

# loading stuff stuff
@onready var v_box_container: VBoxContainer = $Login/VBoxContainer
@onready var erreurs_label: Label = $Login/VBoxContainer/ErreursLabel
@onready var proceed_button: Button = $Login/VBoxContainer/ProceedButton
@onready var title_label: Label = $Login/VBoxContainer/TitleLabel

func clear() -> void:
	username_line_edit.text = ""
	mot_de_passe_line_edit.text = ""
	error_login_label.text = ""
	url_option_button.button_pressed = false
	panel_container.show()
	title_label.text = "Chargement des données..."
	v_box_container.hide()
	erreurs_label.text = ""
	proceed_button.hide()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# check si l'adresse par défaut existe
	if not FileAccess.file_exists(FILE_IP_PATH):
		error_app_label.notice_warning("Aucune IP par défaut trouvé.")
		return
	# vas chercher l'adresse ip stocker
	var file = FileAccess.open(FILE_IP_PATH, FileAccess.READ)
	if not file:
		error_app_label.notice_error("Fichier IP inouvrable.")
		return
	var ip : String = file.get_as_text().strip_edges()
	file.close()
	url_textline.text = ip
	HttpHelper.BASE_URL = ip
	clear()


func _on_set_url_button_pressed() -> void:
	url_option_button.button_pressed = false
	HttpHelper.BASE_URL = url_textline.text
	var file = FileAccess.open(FILE_IP_PATH, FileAccess.WRITE)
	if not file:
		error_app_label.notice_error("Stockage de l'IP n'as pas pu être fait.")
		return
	file.store_line(url_textline.text.strip_edges())
	file.close()
	error_app_label.notice_success("Nouvelle IP enregistrée.")


func _on_button_toggled(toggled_on: bool) -> void:
	url_option_panel.visible = toggled_on

func _on_login_button_pressed() -> void:
	login_button.disabled = true
	error_login_label.text = ""
	var d := {"userName" : username_line_edit.text, "password" : mot_de_passe_line_edit.text}
	var body := JSON.stringify(d).to_utf8_buffer()

	var result : HttpHelper.RequestResult = await HttpHelper.request("/api/login", HTTPClient.METHOD_POST, body)

	if result.result != 0:
		error_app_label.notice_error("Serveur injoignable.")
		error_login_label.text = "Serveur injoignable."
		login_button.disabled = false
		return
	if result.response_code != 200:
		error_login_label.text = "Nom d'utilisateur ou mot de passe invalide."
		login_button.disabled = false
		return
	
	var result_data : Dictionary = JSON.parse_string(result.body.get_string_from_utf8())
	if not result_data.has("token"):
		error_login_label.text = "Aucun token de connexion reçu. Impossible de continuer."
		return
	var token : String = result_data.get("token")
	Globals.is_admin = result_data.get("isAdmin", false)
	HttpHelper.add_headers("Authorization: Bearer %s" % token)
	# load some stuff up
	await load_some_stuff_up()
	if erreurs_label.text != "":
		title_label.text = "Erreur(s) détecté. Continuer?"
		proceed_button.show()
		await proceed_button.pressed
	clear()
	login_button.disabled = false
	SceneManager.load_from_file("res://main_app/main.tscn", false)

func parse_array_response(res, nom: String) -> Variant:
	if res.result != 0:
		erreurs_label.text += "%s: Serveur injoignable\n" % nom
		return null
	if res.response_code != 200:
		erreurs_label.text += "%s: Erreur (%s)\n" % [nom, res.response_code]
		return null
	var data = JSON.parse_string(res.body.get_string_from_utf8())
	if data is not Array:
		erreurs_label.text += "%s: Mauvais type attendu\n" % nom
		return null
	return data

func load_some_stuff_up():
	title_label.text = "Chargement des données..."
	erreurs_label.text = ""
	proceed_button.hide()
	panel_container.hide()
	v_box_container.show()
	var res : HttpHelper.RequestResult
	var data = []
	res = await HttpHelper.request("/api/varieties", HTTPClient.METHOD_GET)
	data = parse_array_response(res, "Variétés")
	if data != null and not data == []:
		Globals.varieties = Variety.from_response_list(data)
	
	res = await HttpHelper.request("/api/formats", HTTPClient.METHOD_GET)
	data = parse_array_response(res, "Formats")
	if data != null and not data == []:
		Globals.formats = Format.from_response_list(data)
	
	res = await HttpHelper.request("/api/stocks", HTTPClient.METHOD_GET)
	data = parse_array_response(res, "Stocks")
	if data != null and not data == []:
		Globals.stocks = Stock.from_response_list(data)


func _on_button_pressed() -> void:
	username_line_edit.text = "admin"
	mot_de_passe_line_edit.text = "user123"
	_on_login_button_pressed()
