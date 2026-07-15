extends RefCounted
class_name Variety

var id : int = 0
var name : String = ""

static func from_response(d : Dictionary) -> Variety:
	var v : Variety = Variety.new()
	v.id = d.get("id", 0)
	v.name = d.get("name", "")
	return v

static func from_response_list(a : Array[Dictionary]) -> Array[Variety]:
	var av : Array[Variety] = []
	for v in a:
		av.append(Variety.from_response(v))
	return av

func to_request() -> Dictionary:
	return {"Name" : name}
