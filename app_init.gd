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

func clear() -> void:
	username_line_edit.text = ""
	mot_de_passe_line_edit.text = ""
	error_login_label.text = ""
	url_option_button.button_pressed = false

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
	clear()
	SceneManager.load_from_file("res://main_app/main.tscn", false)
		
