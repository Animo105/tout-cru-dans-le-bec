extends RefCounted
class_name Variety

var id : int = 0
var name : String = ""
var protocols : Dictionary[Activity.ActivityType, Protocol] = {}

static func from_response(d : Dictionary) -> Variety:
	var v : Variety = Variety.new()
	v.id = d.get("id", 0)
	v.name = d.get("name", "")
	if d.has("protocols"):
		for protocol in d["protocols"]:
			var p = Protocol.from_response(protocol)
			v.protocols[p.activity_type] = p
	return v

static func from_response_list(a : Array) -> Array[Variety]:
	var av : Array[Variety] = []
	for v in a:
		if v is Dictionary:
			av.append(Variety.from_response(v))
	return av

func get_protocol_description(type : Activity.ActivityType)-> String:
	if protocols.has(type):
		return protocols[type].description
	return "Non assigné"

func to_request() -> Dictionary:
	return {"Name" : name}
