extends RefCounted
class_name Product

var id : int = 0
var name : String = ""

static func from_response(d : Dictionary) -> Product:
	var p : Product = Product.new()
	p.id = d.get("id", 0)
	p.name = d.get("name", "")
	return p

static func from_response_list(a : Array[Dictionary]) -> Array[Product]:
	var ap : Array[Product] = []
	for p in a:
		ap.append(Product.from_response(p))
	return ap

func to_request() -> Dictionary:
	return {"Name" : name}
