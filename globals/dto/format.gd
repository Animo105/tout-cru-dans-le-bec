extends RefCounted
class_name Format

var id : int = 0
var format : String = ""

static func from_response(d : Dictionary) -> Format:
	var f : Format = Format.new()
	f.id = d.get("id", 0)
	f.format = d.get("format", "")
	return f

static func from_response_list(a : Array) -> Array[Format]:
	var af : Array[Format] = []
	for f in a:
		if f is Dictionary:
			af.append(Format.from_response(f))
	return af

func to_request() -> Dictionary:
	return {"format" : format}

func to_byte_array() -> PackedByteArray:
	var d = to_request()
	return JSON.stringify(d).to_utf8_buffer()
