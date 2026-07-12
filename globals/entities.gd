extends Node

class Product:
	var id : int = 0
	var name : String = ""
	
	static func from_dictionary(d : Dictionary) -> Product:
		var p : Product = Product.new()
		p.id = d.get("id", 0)
		p.name = d.get("name", "")
		return p
	
	func serialize() -> String:
		var d : Dictionary = {}
		d["id"] = id
		d["name"] = name
		return JSON.stringify(d)

class Ingredient:
	var id : int = 0
	var delivery_id : int = 0
	var batch_number : String = ""
	var variety_name : String = ""
	var quantity_kg : float = 0
	var material_type : int = 0
	
	static func from_dictionary(d : Dictionary) -> Ingredient:
		var i : Ingredient = Ingredient.new()
		i.id = d.get("id", 0)
		i.delivery_id = d.get("deliveryId", 0)
		i.batch_number = d.get("batchNumber", "")
		i.variety_name = d.get("varietyName", "")
		i.quantity_kg = d.get("quantityKg", 0)
		i.material_type = d.get("materialType", 0)
		return i
	
	func serialize() -> String:
		var d : Dictionary = {}
		d["id"] = id
		d["deliveryId"] = delivery_id
		d["batchNumber"] = batch_number
		d["varietyName"] = variety_name
		d["quantityKg"] = quantity_kg
		d["materialType"] = material_type
		return JSON.stringify(d)

class Delivery:
	var id : int = 0
	var batch_number : String = ""
	var quantity_kg : float = 0
	var delivery_date : String = ""
	var supplier : String = ""
	var variety_id : int = 0
	var variety_name : String = ""
