BaseModel = require "./baseModel"

# A base class to build from for player items
class Item
	constructor: (p_options) ->
		{@name} = p_options