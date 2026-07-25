extends PanelContainer
@onready var NouvelleVariétéPopUp: MarginContainer = $"NouvelleVariétéPopUp"
@onready var variety_pannel_main: MarginContainer = $VarietyPannelMain
@onready var modifier: Button = %Modifier
@onready var supprimer: Button = %Supprimer
@onready var variete_infos_container: ScrollContainer = %VarieteInfosContainer
@onready var variete_infos_label: RichTextLabel = %VarieteInfosLabel
@onready var varieties: OptionButton = $VarietyPannelMain/FormatList/Varieties

@onready var nouvelle_variete_nom: TextEdit = %NouvelleVarieteNom
@onready var trempage_protocol: TextEdit = %TrempageProtocol
@onready var deshaydratage_protocol: TextEdit = %DeshaydratageProtocol
@onready var ensachage_protocol: TextEdit = %EnsachageProtocol
@onready var transformation_protocol: TextEdit = %TransformationProtocol

func _ready() -> void:
	varieties.add_item("Sélectionnez", 0)
	for x : Variety in Globals.varieties:
		varieties.add_item(x.name, x.id)

func _on_new_variety_button_pressed() -> void:
	variety_pannel_main.hide()
	NouvelleVariétéPopUp.show()


func _on_add_variety_button_pressed() -> void:
	#fuck that shit
	NouvelleVariétéPopUp.hide()
	variety_pannel_main.show()


func _on_varieties_item_selected(index: int) -> void:
	if index == 0:
		variete_infos_container.hide()
		return
	for x : Variety in Globals.varieties:
		if x.id == index:
			variete_infos_label.text = "[b]Trempage:[/b] \n%s\n" % x.get_protocol_description(Activity.ActivityType.Trempage)
			variete_infos_label.text += "[b]Deshydratage:[/b] \n%s\n" % x.get_protocol_description(Activity.ActivityType.Deshydratage)
			variete_infos_label.text += "[b]Transformation:[/b] \n%s\n" % x.get_protocol_description(Activity.ActivityType.Transformation)
			variete_infos_label.text += "[b]Ensachage:[/b] \n%s\n" % x.get_protocol_description(Activity.ActivityType.Ensachage)
			
	variete_infos_container.show()
	modifier.show()
	supprimer.show()
	


func _on_modifier_pressed() -> void:
	for x : Variety in Globals.varieties:
		if x.id == varieties.selected:
			nouvelle_variete_nom.text = x.name
			trempage_protocol.text = x.get_protocol_description(Activity.ActivityType.Trempage)
			deshaydratage_protocol.text = x.get_protocol_description(Activity.ActivityType.Deshydratage)
			ensachage_protocol.text = x.get_protocol_description(Activity.ActivityType.Transformation)
			transformation_protocol.text = x.get_protocol_description(Activity.ActivityType.Ensachage)
	variety_pannel_main.hide()
	NouvelleVariétéPopUp.show()
