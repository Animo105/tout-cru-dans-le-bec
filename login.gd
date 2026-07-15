extends Control
@onready var username: LineEdit = $PanelContainer/MarginContainer/VBoxContainer/Username
@onready var mot_de_passe: LineEdit = $PanelContainer/MarginContainer/VBoxContainer/MotDePasse
@onready var nouvelle_ip: LineEdit = $PanelContainer/MarginContainer/VBoxContainer/NouvelleIP

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_login_button_pressed() -> void:
	var my_dict = {"UserName" : username.text, "Password" : mot_de_passe.text}
	var body = JSON.stringify(my_dict).to_utf8_buffer()
	
	if await HttpHelper.request(HttpHelper.BASE_URL + "/api/login", HTTPClient.METHOD_POST, body):
		SceneManager.load_from_file("res://main_app/main.tscn", false)


func _on_change_ip_pressed() -> void:
	HttpHelper.BASE_URL = nouvelle_ip.text
	nouvelle_ip.text = ""
