extends PanelContainer
@onready var num_lot: OptionButton = %NumLot
@onready var quantite_deshydrate: SpinBox = %QuantiteDeshydrate
@onready var nombre_deshydrateurs: SpinBox = %NombreDeshydrateurs
@onready var variete: OptionButton = %Variete
@onready var envoyer: Button = $VBoxContainer/Envoyer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	variete.add_item("Sélectionnez")
	for x : Variety in Globals.varieties:
		variete.add_item(x.name)


func _on_envoyer_pressed() -> void:
	envoyer.disabled = true
	
	if variete.selected == null:
		ErrorService.display_error("Une ou plusieurs entrés sont invalides")
		return
	elif num_lot.selected == null:
		ErrorService.display_error("Une ou plusieurs entrés sont invalides")
		return
	elif nombre_deshydrateurs == null:
		ErrorService.display_error("Une ou plusieurs entrés sont invalides")
		return
	elif quantite_deshydrate.text == null:
		ErrorService.display_error("Une ou plusieurs entrés sont invalides")
		return
	
	var trempage : Activity = Activity.new()
	
	trempage.activity_type = Activity.ActivityType.Deshydratage
	trempage.batch_number = num_lot.text
	trempage.data = { "quantitykg" : quantite_deshydrate.value, "nombredeshydrateurs" : nombre_deshydrateurs.value }
	trempage.variety_id = variete.selected
	
	var result : HttpHelper.RequestResult = await HttpHelper.request("/api/deliveries", HTTPClient.METHOD_POST, trempage.to_byte_array())
	if result.result != 0:
		ErrorService.display_error("Serveur injoignable.")
		envoyer.disabled = false
		return
	if result.response_code != 200:
		ErrorService.display_error("Information entrée invalide. CODE : " + str(result.response_code))
		envoyer.disabled = false
		return
