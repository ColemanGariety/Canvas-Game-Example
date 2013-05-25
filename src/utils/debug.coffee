_ = require "lodash"
debug = require "debug"
util = require "util"

# Add global debug instances here
module.exports = _.merge debug,
	app:
		info: debug "app:info"
		error: debug "app:error"
	inspect: (p_object, p_showHidden = false, p_depth = null, p_colors = true) ->
		return util.inspect p_object, p_showHidden, p_depth, p_colors