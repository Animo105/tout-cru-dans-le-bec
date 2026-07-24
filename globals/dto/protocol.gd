extends RefCounted
class_name Protocol

var variety_id : int = 0
var activity_type : Activity.ActivityType = Activity.ActivityType.Trempage
var description : String = ""

static func from_response(d : Dictionary) -> Protocol:
	var p = Protocol.new()
	p.variety_id = d.get("varietyId", 0)
	p.activity_type = d.get("activityType", 0)
	p.description = d.get("description", "")
	return p

static func from_response_list(a : Array[Dictionary]) -> Array[Protocol]:
	var ap : Array[Protocol] = []
	for p in a:
		ap.append(Protocol.from_response(p))
	return ap

func to_request() -> Dictionary:
	var d : Dictionary = {}
	d["varietyId"] = variety_id
	d["activityType"] = activity_type
	d["description"] = description
	return d
