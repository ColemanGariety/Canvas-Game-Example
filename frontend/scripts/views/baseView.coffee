# Base view to extend all other views from
class BaseView extends createjs.Container
	constructor: (p_options) ->
		{@model, @asset} = p_options

		@addChild @asset