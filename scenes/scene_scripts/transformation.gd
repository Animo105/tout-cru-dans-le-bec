extends PanelContainer
@onready var num_lot: OptionButton = %NumLot
@onready var variete: OptionButton = %Variete
@onready var bouton_produit: OptionButton = %BoutonProduit
@onready var quantite_produite: SpinBox = %QuantiteProduite
@onready var taille_produit: OptionButton = %TailleProduit
@onready var envoyer: Button = %Envoyer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	variete.add_item("Sélectionnez", 0)
	for x : Variety in Globals.varieties:
		variete.add_item(x.name)
	bouton_produit.add_item("Sélectionnez", 0)
	bouton_produit.add_item("Beurre")
	bouton_produit.add_item("Sachet")
	taille_produit.add_item("Sélectionnez", 0)
	for x : Format in Globals.formats:
		taille_produit.add_item(x.format)
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
