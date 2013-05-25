debug = require './debug'

process.on 'uncaughtException', (p_error) ->
	debug.app.error p_error.stack