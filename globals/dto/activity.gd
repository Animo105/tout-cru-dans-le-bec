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
	a.completed_by_user_name = d.get("completedByUserName", "")

	a.started_date = d.get("startedDate", "")
	a.completed_date = d.get("completedDate", "")

	a.variety_id = d.get("varietyId", 0)
	a.batch_number = d.get("batchNumber", "")
	a.data = d.get("data")

	return a

static func from_response_list(arr : Array[Dictionary]) -> Array[Activity]:
	var out : Array[Activity] = []
	for d in arr:
		out.append(from_response(d))
	return out

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
