extends Control
@onready var accueil: Control = $Background/VBoxContainer/MarginContainer/HBoxContainer/SceneContainer/MarginContainer/Accueil
@onready var deshydratage: Control = $Background/VBoxContainer/MarginContainer/HBoxContainer/SceneContainer/MarginContainer/Deshydratage
@onready var ensachage: Control = $Background/VBoxContainer/MarginContainer/HBoxContainer/SceneContainer/MarginContainer/Ensachage
@onready var historique: Control = $Background/VBoxContainer/MarginContainer/HBoxContainer/SceneContainer/MarginContainer/Historique
@onready var reception: Control = $Background/VBoxContainer/MarginContainer/HBoxContainer/SceneContainer/MarginContainer/Reception
@onready var stock_deshydrate: Control = $Background/VBoxContainer/MarginContainer/HBoxContainer/SceneContainer/MarginContainer/StockDeshydrate
@onready var transformation: Control = $Background/VBoxContainer/MarginContainer/HBoxContainer/SceneContainer/MarginContainer/Transformation
@onready var trempage: Control = $Background/VBoxContainer/MarginContainer/HBoxContainer/SceneContainer/MarginContainer/Trempage


var scenes: Array[Control]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scenes = [
		accueil,
		deshydratage,
		ensachage,
		historique,
		reception,
		stock_deshydrate,
		transformation,
		trempage
	]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hideAll() -> void:
	for x in scenes:
		x.hide()

func _on_accueil_pressed() -> void:
	hideAll()
	accueil.show()


func _on_deshydratage_pressed() -> void:
	hideAll()
	deshydratage.show()


func _on_reception_pressed() -> void:
	hideAll()
	reception.show()


func _on_trempage_pressed() -> void:
	hideAll()
	trempage.show()


func _on_stock_deshydrate_pressed() -> void:
	hideAll()
	stock_deshydrate.show()


func _on_ensachage_pressed() -> void:
	hideAll()
	ensachage.show()

func _on_transformation_pressed() -> void:
	hideAll()
	transformation.show()

func _on_historique_pressed() -> void:
	hideAll()
	historique.show()


func _on_deconexion_pressed() -> void:
	SceneManager.load_previous_scene()
