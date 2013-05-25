config = require './src/utils/config' # Load the config module here to ensure defaults are established
debug = require './src/utils/debug'
# require './src/utils/catch-all'
express = require 'express'
http = require 'http'

debug.app.info "Starting application in #{config.get 'NODE_ENV'} mode"

# Express
app = express()

# Add middleware
app.use express.compress()
app.use express.static("#{__dirname}/public")

# Start the webapp
http.createServer(app).listen(config.get('express').ports.http, -> debug.app.info("HTTP server started on port #{config.get('express').ports.http}"))