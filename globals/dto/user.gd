extends RefCounted
class_name User

enum UserType {
	User,
	SuperUser,
}

var id : int = 0
var name : String = ""
var user_type : UserType = UserType.User

static func from_response(d : Dictionary) -> User:
	var v : User = User.new()
	v.id = d.get("id", 0)
	v.name = d.get("name", "")
	v.user_type = d.get("userType", UserType.User)
	return v

static func from_response_list(a : Array) -> Array[User]:
	var av : Array[User] = []
	for v in a:
		if v is Dictionary:
			av.append(User.from_response(v))
	return av

func to_request() -> Dictionary:
	return {"Name" : name}
