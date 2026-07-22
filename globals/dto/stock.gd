extends Node
class_name Stock

enum StockType
{
	Cru = 0,
	Deshydrate = 1
	
}

var id : int = 0
var variety : Variety = null
var batch_number : String = ""
var quantity_kg : float = 0.0
var stock_type : StockType = StockType.Cru

func variety_id_setter(value : int):
	if not variety:
		variety = Variety.new()
	variety.id = value 

static func from_response(d : Dictionary) -> Stock:
	var s = Stock.new()
	s.id = d.get("id", 0)
	s.batch_number = d.get("batchNumber", "")
	s.quantity_kg = d.get("quantityKg", 0.0)
	s.stock_type = d.get("stockType", StockType.Cru)
	if d.has("variety"):
		s.variety = Variety.from_response(d["variety"])
	return s

static func from_response_list(arr : Array) -> Array[Stock]:
	var out : Array[Stock] = []
	for d in arr:
		if d is Dictionary:
			out.append(from_response(d))
	return out

func to_request() -> Dictionary:
	var d : Dictionary = {}
	if variety : d["varietyId"] = variety.id
	d["batchNumber"] = batch_number
	d["quantityKg"] = quantity_kg
	d["stockType"] = stock_type
	return d

func to_byte_array() -> PackedByteArray:
	var d = to_request()
	return JSON.stringify(d).to_utf8_buffer()
