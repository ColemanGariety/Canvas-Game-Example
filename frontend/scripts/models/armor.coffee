Item = require "./item"

# Armor describes how characters mitigate damage
class Armor extends Item
	constructor: (p_options) ->
		super p_options

		@type = "armor"

		{@itemSlot, @damageModifier, @criticalModifier} = p_options

module.exports = Armor