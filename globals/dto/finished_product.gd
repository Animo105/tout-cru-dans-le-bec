extends RefCounted
class_name FinishedProduct

enum ProductType
{
	Pot = 0,
	Sachet = 1
}

var id : int = 0
var product_id : int = 0
var product_name : String = ""
var format_id : int = 0
var format : String = ""
var batch_number : String = ""
var product_type : ProductType = ProductType.Pot
var quantity : int = 0
var date_production : String = ""
var products_unique_id : String = ""

static func from_response(d : Dictionary) -> FinishedProduct:
	var fp := FinishedProduct.new()
	fp.id = d.get("id", 0)
	fp.product_name = d.get("productName", "")
	fp.format = d.get("format", "")
	fp.batch_number = d.get("batchNumber", "")
	fp.product_type = d.get("productType", 0)
	fp.quantity = d.get("quantity", 0)
	fp.date_production = d.get("dateProduction", "")
	fp.products_unique_id = d.get("productsUniqueId", "")
	return fp

static func from_response_list(a : Array[Dictionary]) -> Array[FinishedProduct]:
	var afp : Array[FinishedProduct] = []
	for fp in a:
		afp.append(from_response(fp))
	return afp

func to_request() -> Dictionary:
	return {
		"productId": product_id,
		"formatId": format_id,
		"batchNumber": batch_number,
		"productType": product_type,
		"quantity": quantity,
		"productsUniqueId": products_unique_id
	}
