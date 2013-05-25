BaseModel = require "./baseModel"

# Describes a character in the game
class Character extends BaseModel
	constructor: (p_options) ->
		super

		{@x, @y, @movementSpeed, @maximumHealth, @currentHealth, @weapons} = p_options

		# Apply defaults if the properties weren't passed into the constructor
		@x ?= 0
		@y ?= 0
		@movementSpeed ?= 1
		@maximumHealth ?= 100
		@currentHealth ?= @maximumHealth

		@armorSlots =
			head: null
			chest: null
			gloves: null
			shoulders: null
			pants: null	
			boots: null

		@inventory = []

	equipWeapon: (p_weaponModel) ->
		@weapon = p_weaponModel
		@emit "character.weaponEquipped"

	equipArmor: (p_armorModel) ->
		@armorSlots
		@emit "character.armorEquipped"