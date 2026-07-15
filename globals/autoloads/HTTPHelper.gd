## HTTP helper singleton used to send and manage HTTP requests.[br]
##[br]
## This class wraps multiple [HTTPRequest] node and provides:[br]
## - A request queue (one request processed at a time)[br]
## - An async API using `await`[br]
## - A per-request result system via the inner class RequestResult[br]
##[br]
## Requests are queued automatically and processed sequentially.[br]
## Each call to [method request] will wait for its own response,
## even if multiple requests are in progress.[br]
##[br]
## Example usage:[br]
## [codeblock]
## HTTPHelper.BASE_URL = "localhost/"
## var body : Dictionary = { "UserName" : "SuperUser" , "Password" : "User123" }
## var data = JSON.stringify(body).to_utf8_buffer()
## var res : HTTPHelper.RequestResult = await HTTPHelper.request("api/login", HTTPClient.METHOD_POST, data)
##
## if res.result != OK
##     print("Didn't find server")
## res.response_code == 200:
##     print(res.body)
## [/codeblock][br]
##[br]
## Notes:[br]
## - All URLs passed to [method request] are appended to [member BASE_URL][br]
## - The [signal request_completed] is emitted for EVERY completed request
##   (not filtered per caller)[br]
## - Internally, each request is identified using a unique ID[br]
##[br]
## - Assumes JSON responses if body parsing is used[br]
##[br]


extends Node

## Emitted whenever ANY HTTP request completes.[br]
## [br]
## Important:[br]
## This signal is global and does not distinguish which request finished.[br]
## You must use the request_id inside the RequestResult to identify the correct request.[br]
## The method [method request] already use this to return the correct result.
signal request_completed(request_result : RequestResult)


## Base URL used for all requests.[br]
## [br]
## The provided URL in [method request] will be appended to this base.[br]
## Example:[br]
## BASE_URL = "https://monsite.com/api/"[br]
## request("users") → "https://monsite.com/api/users"[br]
var BASE_URL : String = ""

var _request_headers : Array[String] = ["Content-Type: application/json"]

var _request_queue : Array[_Request] = []
var _request_count : int = 0

var _request_pool : Array[HTTPRequest] = []
var _available_requests : Array[HTTPRequest] = []
var _busy_requests : Dictionary[HTTPRequest, int] = {}

func _ready() -> void:
	var pool_size : int = 8
	for i in range(pool_size):
		var req : HTTPRequest = HTTPRequest.new()
		add_child(req)
		req.request_completed.connect(_request_completed.bind(req))
		_request_pool.append(req)
		_available_requests.append(req)

func _process(_delta: float) -> void:
	while not _available_requests.is_empty() and not _request_queue.is_empty():
		var current_request : _Request = _request_queue.pop_front()
		var http : HTTPRequest = _available_requests.pop_back()
		_busy_requests[http] = current_request.id
		var err = http.request_raw(current_request.url, current_request.headers, current_request.method, current_request.body)
		if err != OK:
			_busy_requests.erase(http)
			_available_requests.append(http)

func _merge_headers(global: Array[String], local: Array[String]) -> Array[String]:
	var result : Array[String] = global.duplicate()
	if local.is_empty(): return result
	for header in local:
		var key : String = header.split(":")[0]
		for i in range(result.size()):
			if result[i].begins_with(key + ":"):
				result.remove_at(i)
				break
		result.append(header)
	return result

func _await_request(request_id : int) -> RequestResult:
	while true:
		var result : RequestResult = await request_completed
		if result.request_id == request_id:
			return result
	return null

func _request_completed(result : int, response_code : int, _headers : PackedStringArray, body : PackedByteArray, http : HTTPRequest) -> void:
	var request_id : int = _busy_requests.get(http, -1)
	if request_id == -1:
		return
	_busy_requests.erase(http)
	_available_requests.append(http)
	var request_result : RequestResult = RequestResult.new(request_id, result, response_code, body)
	request_completed.emit(request_result)

## Adds a header to be included in all future HTTP requests.[br]
##[br]
## Headers must be formatted as "Key: Value".[br]
## Example:[br]
## add_headers("Authorization: Bearer token")[br]
##[br]
## Note:[br]
## Headers are stored globally and will persist until cleared.
func add_headers(header : String) -> void:
	if header not in _request_headers:
		_request_headers.append(header)

## Resets the request headers to their default values.[br]
##[br]
## By default, this sets:[br]
## - "Content-Type: application/json"[br]
##[br]
## Call this before redefining headers if you want to avoid duplicates.
func clear_headers() -> void:
	_request_headers = ["Content-Type: application/json"]

## Returns whether a request is currently being processed.
##
## Since only one request can be processed at a time,
## this indicates if the HTTP system is busy.
##
## @return true if a request is currently in progress, false otherwise
func is_processing_request()-> bool:
	return not _busy_requests.is_empty()
## Sends an HTTP request.[br]
##[br]
## The request is added to an internal queue and processed sequentially.[br]
## This function is asynchronous and will return once the specific request completes.[br]
##[br]
## @param [param url]: Endpoint path appended to [member BASE_URL][br]
## @param [param method]: HTTP method (see [enum HTTPClient.Method])[br]
## @param [param body]: Data passed to the HTTP request[br]
## @param [param request_specific_headers]: Headers that will be added only to this HTTP request.[br]
##[br]
## @return inner class RequestResult corresponding to THIS request
func request(url : String, method : HTTPClient.Method, body : PackedByteArray = [], request_specific_headers : Array[String] =  []) -> RequestResult:
	var id = _request_count
	_request_count += 1
	var headers = _merge_headers(_request_headers, request_specific_headers)
	var new_request : _Request = _Request.new(BASE_URL+url, method, id, headers, body)
	_request_queue.append(new_request)
	var result = await _await_request(id)
	return result

## Sends an HTTP request.[br]
##[br]
## The request is added to an internal queue and processed sequentially.[br]
## This function return the id of the request and let you use [signal request_completed] to check when it is completed.[br]
##[br]
## @param [param url]: Endpoint path appended to [member BASE_URL][br]
## @param [param method]: HTTP method (see [enum HTTPClient.Method])[br]
## @param [param body]: Data passed to the HTTP request[br]
## @param [param request_specific_headers]: Headers that will be added only to this HTTP request.[br]
##[br]
## @return inner class RequestResult corresponding to THIS request
func request_async(url : String, method : HTTPClient.Method, body : PackedByteArray = [], request_specific_headers : Array[String] = []) -> int:
	var id = _request_count
	_request_count += 1
	var headers = _merge_headers(_request_headers, request_specific_headers)
	var new_request : _Request = _Request.new(BASE_URL+url, method, id, headers, body)
	_request_queue.append(new_request)
	return id

## Represents the result of an HTTP request once it has completed. [br]
## This object is typically returned or emitted after a request finishes processing. [br]
##[br]
## It contains both the low-level request result (transport status) [br]
## and the HTTP response data returned by the server.
class RequestResult:

	## Unique identifier of the request.[br]
	## This is used internally to match a response to its originating request,[br]
	## especially when multiple requests are queued or processed asynchronously.
	var request_id : int

	## Result status of the request at the engine level.[br]
	## Corresponds to [enum HTTPRequest.Result] enum.[br]
	## Example values:[br]
	## - OK (0): Request completed successfully[br]
	## - ERR_CANT_CONNECT (3): Failed to connect to host[br]
	## - ERR_TIMEOUT: Request timed out[br]
	##[br]
	## Warning: This is NOT the HTTP status code.
	var result : int

	## HTTP response status code returned by the server.[br]
	## Common values:[br]
	## - 200: OK[br]
	## - 404: Not Found[br]
	## - 500: Internal Server Error[br]
	##[br]
	## Will be 0 if the request failed before reaching the server.
	var response_code : int

	## raw body returned by the request.
	var body : PackedByteArray


	func _init(id : int ,r : int, rc : int, b : PackedByteArray) -> void:
		request_id = id
		result = r
		response_code = rc
		body = b
	
	func get_body_as_string() -> String:
		return body.get_string_from_utf8()
	
	func _to_string() -> String:
		return "result(engine): %s\nresponse_code: %s\nbody: %s" % [result, response_code, get_body_as_string()]


class _Request:
	var method : HTTPClient.Method
	var url : String
	var id : int
	var headers : Array[String]
	var body : PackedByteArray
	func _init(request_url : String, request_method : HTTPClient.Method, request_id : int, request_headers : Array[String], request_body : PackedByteArray) -> void:
		method = request_method
		url = request_url
		id = request_id
		headers = request_headers.duplicate()
		body = request_body
	func _to_string() -> String:
		return "url: %s,\nmethod: %s\nheaders: %s\nbody: %s" % [url, method, headers, body]
