extends Control
@onready var variete: OptionButton = $PanelContainer/PanelContainer/VBoxContainer/Variete
@onready var num_fournisseur: LineEdit = $PanelContainer/PanelContainer/VBoxContainer/NumFournisseur
@onready var quantite_recus: SpinBox = $PanelContainer/PanelContainer/VBoxContainer/QuantiteRecus
@onready var kg_recus: SpinBox = $PanelContainer/PanelContainer/VBoxContainer/KgRecus
@onready var package_type: OptionButton = $PanelContainer/PanelContainer/VBoxContainer/PackageType
@onready var batch_number: LineEdit = $PanelContainer/PanelContainer/VBoxContainer/BatchNumber


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_envoyer_pressed() -> void:
	var delivery : Delivery
	#delivery.variety = variete.selected
	delivery.supplier_name = num_fournisseur.text
	delivery.quantity = quantite_recus.value
	delivery.package_weight_kg = kg_recus.value
	#delivery.package_type = package_type.selected
	delivery.batch_number = batch_number.text
	
	#evoie la delivery dans la bd
