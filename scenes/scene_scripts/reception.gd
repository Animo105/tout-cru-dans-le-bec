extends Control
@onready var variete: OptionButton = %Variete
@onready var num_fournisseur: LineEdit = %NumeroFournisseur
@onready var quantite_recus: SpinBox = %QuantiteRecus
@onready var poid_recus: SpinBox = %PoidRecus
@onready var package_type: OptionButton = %PackageType
@onready var batch_number: LineEdit = %BatchNumber
@onready var envoyer: Button = $"PanelContainer_PanelContainer#VBoxContainer/Envoyer"
@onready var type_poid: OptionButton = %TypePoid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	variete.add_item("Sélectionnez", 0)
	for x : Variety in Globals.varieties:
		variete.add_item(x.name, x.id)

func _on_envoyer_pressed() -> void:
	envoyer.disabled = true
	
	if variete.selected == null:
		ErrorService.display_error("Une ou plusieurs entrés sont invalides")
		return
	elif num_fournisseur.text == null:
		ErrorService.display_error("Une ou plusieurs entrés sont invalides")
		return
	elif quantite_recus.value == null:
		ErrorService.display_error("Une ou plusieurs entrés sont invalides")
		return
	elif poid_recus.value == null:
		ErrorService.display_error("Une ou plusieurs entrés sont invalides")
		return
	elif package_type.selected == null:
		ErrorService.display_error("Une ou plusieurs entrés sont invalides")
		return
	elif batch_number.text == null:
		ErrorService.display_error("Une ou plusieurs entrés sont invalides")
		return
	
	if type_poid.selected == 0:
		poid_recus.value /= 2.205
	
	var delivery : Delivery = Delivery.new()
	delivery.variety_id_setter(variete.selected)
	delivery.supplier_name = num_fournisseur.text
	delivery.quantity = quantite_recus.value
	delivery.package_weight_kg = poid_recus.value
	delivery.package_type = package_type.selected
	delivery.batch_number = batch_number.text
	
	var stock : Stock = Stock.new()
	stock.quantity_kg = poid_recus.value
	stock.variety_id_setter(variete.selected)
	stock.batch_number = batch_number.text
	
	var result : HttpHelper.RequestResult = await HttpHelper.request("/api/deliveries", HTTPClient.METHOD_POST, delivery.to_byte_array())
	if result.result != 0:
		ErrorService.display_error("Serveur injoignable.")
		envoyer.disabled = false
		return
	if result.response_code != 200:
		ErrorService.display_error("Information entrée invalide. CODE : " + str(result.response_code))
		envoyer.disabled = false
		return
	
	result = await HttpHelper.request("/api/stocks", HTTPClient.METHOD_POST, stock.to_byte_array())
	if result.result != 0:
		ErrorService.display_error("Serveur injoignable.")
		envoyer.disabled = false
		return
	if result.response_code != 200:
		ErrorService.display_error("Problème lors de la création du stock. CODE : " + str(result.response_code))
		envoyer.disabled = false
		return
	
	envoyer.disabled = false
