nconf = require 'nconf'

nconf.argv().env()

nconf.defaults
	NODE_ENV: "development"

nconf.file "express", "#{__dirname}/../../config/#{nconf.get 'NODE_ENV'}/express.json"
nconf.file "debug", "#{__dirname}/../../config/#{nconf.get 'NODE_ENV'}/debug.json"

process.env.DEBUG ?= nconf.get("DEBUG")

module.exports = nconf