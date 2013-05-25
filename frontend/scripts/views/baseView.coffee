# Base view to extend all other views from
class BaseView
	constructor: (p_options) ->
		{@model, @media} = p_options