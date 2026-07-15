extends RefCounted
class_name Delivery

enum PackageType
{
	Boite = 0,
	sac = 1
}

var id : int = 0
var supplier_name : String = ""
var package_type : PackageType = PackageType.Boite
var package_weight_kg : float = 0.0
var quantity : int = 0
var variety : Variety = null
var batch_number : String = ""
var delivery_date : String = ""

static func from_response(d : Dictionary) -> Delivery:
	var e = Delivery.new()
	e.id = d.get("id", 0)
	e.supplier_name = d.get("supplierName", "")
	e.package_type = d.get("packageType", PackageType.Boite)
	e.quantity = d.get("packageQuantity", 0)
	e.batch_number = d.get("batchNumber", "")
	e.delivery_date = d.get("deliveryDate", "")
	if d.has("variety"): e.variety = Variety.from_response(d["variety"])
	return e

func to_request() -> Dictionary:
	var d : Dictionary = {}
	d["id"] = id
	d["supplierName"] = supplier_name
	d["packageType"] = package_type
	d["packageWeightKg"] = package_weight_kg
	d["packageQuantity"] = quantity
	if variety: d["varietyid"] = variety.id
	return d
	
