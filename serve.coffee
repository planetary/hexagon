#!/usr/bin/env coffee
app = require './app'
config = require './config'

# start server
app.listen config.server.port, ->
    console.log("Server started on #{config.server.port}. To stop, hit Ctrl + C")
