extends Node

var is_admin : bool = false

var formats : Array[Format] = []
var varieties : Array[Variety] = []
var stocks : Array[Stock] = []
var activities : Array[Activity] = []

func get_stock(id : int, is_raw : bool = true) -> Stock:
	var type : Stock.StockType = Stock.StockType.Cru if is_raw else Stock.StockType.Deshydrate
	for stock in stocks:
		if stock.stock_type != type:
			continue
		if stock.id == id:
			return stock
	return null
