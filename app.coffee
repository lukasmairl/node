
###
Module dependencies.
###
cloudinary = require("cloudinary")
express = require("express")
routes = require("./routes")
path = require("path")
util = require("util")
expressValidator = require("express-validator")
http = require("http")
https = require("https")
path = require("path")
app = express()

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", __dirname + "/views"
app.set "view engine", "jade"
app.use express.favicon()
app.use express.logger("dev")
app.use express.bodyParser()
app.use expressValidator()
app.use express.methodOverride()
app.use app.router
app.use express.static(path.join(__dirname, "public"))
app.configure "development", ->
  app.use express.errorHandler()
  cloudinary.config
    cloud_name: "dppy0fyoh"
    api_key: "111985222765819"
    api_secret: "_d-Ou9tAc8CwGM6jdhBbw1ZM4V8"


app.locals.api_key = cloudinary.config().api_key
app.locals.cloud_name = cloudinary.config().cloud_name

# development only
app.use express.errorHandler()  if "development" is app.get("env")

#INDEX ROUTES
require("./routes/index") app

#REST API ROUTES
require("./routes/api") app

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
