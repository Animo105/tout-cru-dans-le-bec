extends Control
@onready var username: LineEdit = $PanelContainer/MarginContainer/VBoxContainer/Username
@onready var mot_de_passe: LineEdit = $PanelContainer/MarginContainer/VBoxContainer/MotDePasse
@onready var nouvelle_ip: LineEdit = $PanelContainer/MarginContainer/VBoxContainer/NouvelleIP
@onready var error_msg: Label = $PanelContainer/MarginContainer/VBoxContainer/ErrorMsg

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_login_button_pressed() -> void:
	var my_dict = {"UserName" : username.text, "Password" : mot_de_passe.text}
	var body = JSON.stringify(my_dict).to_utf8_buffer()
	
	var result := await HttpHelper.request("/api/login", HTTPClient.METHOD_POST, body)
	print(result.result)
	print(result.response_code)
	if result.result != 0:
		error_msg.text = "cant reach server"
		error_msg.show()
	else :
		if result.response_code == 200:
			var result_data : Dictionary = JSON.parse_string(result.body.get_string_from_utf8())
			var token : String = result_data["token"]
			HttpHelper.add_headers("Authorization: Bearer %s" % token)
			SceneManager.load_from_file("res://main_app/main.tscn", false)
		else:
			error_msg.text = "wrong login info"
			error_msg.show()


func _on_change_ip_pressed() -> void:
	HttpHelper.BASE_URL = nouvelle_ip.text
	print(HttpHelper.BASE_URL)
	nouvelle_ip.text = ""
