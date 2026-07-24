extends RefCounted
class_name Activity

enum ActivityStatus 
{
	Started = 0,
	Completed = 1
}

enum ActivityType
{
	Trempage = 0,
	Deshydratage = 1,
	StockingMaterial = 2,
	Transformation = 3,
	Ensachage = 4
}

const ACTIVITY_TYPE_STRING : Dictionary[int, String] = {
	0 : "Trempage",
	1 : "Déshydratage",
	2 : "Stockage de matériel",
	3 : "Transformation en beurre",
	4 : "Ensachage"
}

const ACTIVITY_STATUS_STRING : Dictionary[int, String] = {
	0 : "En cours",
	1 : "Complété"
}

var id : int = 0
var activity_type : ActivityType = ActivityType.Trempage
var activity_status : ActivityStatus = ActivityStatus.Started

var started_by_user_name : String = ""
var completed_by_user_name : String = ""

var started_date : String = ""
var completed_date : String = ""

var variety_id : int = 0
var batch_number : String = ""

var data : Variant = null

static func from_response(d : Dictionary) -> Activity:
	var a := Activity.new()

	a.id = d.get("id", 0)
	a.activity_type = d.get("activityType", 0)
	a.activity_status = d.get("activityStatus", 0)

	a.started_by_user_name = d.get("startedByUserName", "")
	if d.get("completedByUserName", "") != null:
		a.completed_by_user_name = d.get("completedByUserName", "")

	a.started_date = d.get("startedDate", "")
	if d.get("completedDate", "") != null:
		a.completed_date = d.get("completedDate", "")

	a.variety_id = d.get("varietyId", 0)
	a.batch_number = d.get("batchNumber", "")
	a.data = d.get("data")

	return a

static func from_response_list(arr : Array) -> Array[Activity]:
	var out : Array[Activity] = []
	for d in arr:
		if d is Dictionary:
			out.append(from_response(d))
	return out

func activity_status_as_string() -> String:
	return ACTIVITY_STATUS_STRING[activity_status]

func activity_type_as_string() -> String:
	return ACTIVITY_TYPE_STRING[activity_type]

func to_request() -> Dictionary:
	var d : Dictionary = {}

	d["varietyId"] = variety_id
	d["activityType"] = activity_type
	d["varietyId"] = variety_id
	d["batchNumber"] = batch_number

	if data != null:
		d["data"] = data

	return d

func to_byte_array() -> PackedByteArray:
	var d = to_request()
	return JSON.stringify(d).to_utf8_buffer()
