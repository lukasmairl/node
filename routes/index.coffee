cloudinary = require("cloudinary")
expressValidator = require("express-validator")
Api = require("../api").Api
User = require("../models/User").User

module.exports = (app) ->
  
  #INDEX
  app.get "/", (req, res, next) ->
    cloudinary.api.resources (items) ->
      
      #create empty user object
      user = new User("", "", "", "")
      res.render "index",
        images: items.resources
        cloudinary: cloudinary
        user: user
  
  #FORM POST
  app.post "/", (req, res) ->
    
    #form validation
    req.assert("name", "Please enter a name").notEmpty()
    req.assert("email", "Email address too short").len 6, 64
    req.assert("email", "Please enter a valid email").isEmail()
    req.assert("password", "Please enter a valid password").notEmpty()
    req.assert("password", "Password too short. Must be 5 characters or more.").len 5
    errors = req.validationErrors()
    email = req.body.email
    name = req.body.name
    imageID = req.body.image_id
    password = req.body.password
    
    #create user object from post values
    user = new User(name, email, password, imageID)
    if errors
      res.render "index",
        cloudinary: cloudinary
        errors: errors
        status: "error"
        user: user #prepopulate form fields with post values

    else
      
      #rest api call
      api = new Api()
      api.save user, (result) ->
        
        #on success render success state
        res.render "index",
          cloudinary: cloudinary
          status: result.status
          user: user