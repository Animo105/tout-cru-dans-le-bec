extends PanelContainer
@onready var num_lot: OptionButton = %NumLot
@onready var quantite_trempage: SpinBox = %QuantiteTrempage
@onready var variete: OptionButton = %Variete
@onready var envoyer: Button = $VBoxContainer/Envoyer
@onready var notice_pop_up: NoticePopup = $NoticePopUp



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
	
	if variete.selected == 0:
		ErrorService.display_error("Une ou plusieurs entrés sont invalides")
		return
	elif num_lot.selected == 0:
		ErrorService.display_error("Une ou plusieurs entrés sont invalides")
		return
	elif quantite_trempage.value == null:
		ErrorService.display_error("Une ou plusieurs entrés sont invalides")
		return
	
	var trempage : Activity = Activity.new()
	
	trempage.activity_type = Activity.ActivityType.Trempage 
	trempage.batch_number = num_lot.text
	trempage.data = { "quantitykg" : quantite_trempage.value }
	trempage.variety_id = variete.selected
	
	var result : HttpHelper.RequestResult = await HttpHelper.request("/api/activity/start", HTTPClient.METHOD_POST, trempage.to_byte_array())
	if result.result != 0:
		ErrorService.display_error("Serveur injoignable.")
		envoyer.disabled = false
		return
	if result.response_code != 200:
		ErrorService.display_error("Information entrée invalide. CODE : " + str(result.response_code))
		envoyer.disabled = false
		return
	envoyer.disabled = false
	notice_pop_up.open_popup_with_text("Succes", "Trempage enregistré")
