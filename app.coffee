handlers = require './handlers'

express = require 'express'
morgan = require 'morgan'
parser = require 'body-parser'


# init express
app = express()
app.use(parser.json())
app.use(morgan('dev'))


# prepare handlers
app.post '/manifest', handlers.gollum('#planetary-ops')


module.exports = app
