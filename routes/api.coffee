User = require("../models/User").User
fs = require("fs")

module.exports = (app) ->
  app.post "/api/v1/user", (req, res) ->
    user = new User(req.body.name, req.body.email, req.body.password, req.body.imageID)
    
    #get rid of any whitespace between firstname/lastname
    name = user.name.replace(/\s/g, "")
    
    #STORE USER DATA IN TXT FILE
    stream = fs.createWriteStream(name + ".txt")
    stream.once "open", (fd) ->
      stream.write "firstname/lastname: " + user.name + "\n"
      stream.write "email: " + user.email + "\n"
      stream.write "password: " + user.password + "\n"
      stream.write "image id: " + user.imageID + "\n"
      stream.end()

    res.send status: "success"
