Item = require "./item"

# Weapon describes how characters damage each other
class Weapon extends Item
	constructor: (p_options) ->
		super p_options

		@type = "weapon"

		{@minDamage, @maxDamage, @criticalModifier, @attackSpeed, @maxAmmo, @currentAmmo, @blastRadius} = p_options

		@criticalModifier ?= 0
		@currentAmmo ?= 0
		@blastRadius ?= 0