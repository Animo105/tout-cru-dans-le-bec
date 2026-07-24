extends PanelContainer
@onready var num_lot: OptionButton = %NumLot
@onready var quantite_trempage: SpinBox = %QuantiteTrempage
@onready var variete: OptionButton = %Variete
@onready var envoyer: Button = $VBoxContainer/Envoyer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	variete.add_item("Sélectionnez")
	for x : Variety in Globals.varieties:
		variete.add_item(x.name)
	num_lot.add_item("Sélectionnez une variété")

func _on_variete_item_selected(index: int) -> void:
	num_lot.clear()
	num_lot.add_item("Sélectionnez une variété")
	for x : Stock in Globals.stocks:
		if index == x.id:
			num_lot.add_item(x.batch_number)

func _on_envoyer_pressed() -> void:
	envoyer.disabled = true
	
	if variete.selected == null:
		ErrorService.display_error("Une ou plusieurs entrés sont invalides")
		return
	elif num_lot.selected == null:
		ErrorService.display_error("Une ou plusieurs entrés sont invalides")
		return
	elif quantite_trempage.value == null:
		ErrorService.display_error("Une ou plusieurs entrés sont invalides")
		return
	
	var stock_deshydrate : Activity = Activity.new()
	
	stock_deshydrate.activity_type = Activity.ActivityType.StockingMaterial
	stock_deshydrate.batch_number = num_lot.text
	stock_deshydrate.data = { "quantitykg" : quantite_trempage.value }
	stock_deshydrate.variety_id = variete.selected
	
	var result : HttpHelper.RequestResult = await HttpHelper.request("/api/activity/start", HTTPClient.METHOD_POST, stock_deshydrate.to_byte_array())
	if result.result != 0:
		ErrorService.display_error("Serveur injoignable.")
		envoyer.disabled = false
		return
	if result.response_code != 200:
		ErrorService.display_error("Information entrée invalide. CODE : " + str(result.response_code))
		envoyer.disabled = false
		return
