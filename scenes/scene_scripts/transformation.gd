extends PanelContainer
@onready var num_lot: OptionButton = %NumLot
@onready var variete: OptionButton = %Variete
@onready var quantite_produite: SpinBox = %QuantiteProduite
@onready var taille_produit: OptionButton = %TailleProduit
@onready var envoyer: Button = %Envoyer


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
	
	envoyer.disabled = false
