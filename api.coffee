Api = ->
http = require("http")
Api::save = (user, callback) ->
  user = JSON.stringify(user)
  
  # the post options
  optionspost =
    host: "0.0.0.0"
    port: 3000
    path: "/api/v1/user"
    method: "POST"
    headers:
      "Content-Type": "application/json"
      "Content-Length": user.length

  
  # do the POST call
  req = http.request(optionspost, (res) ->
    console.log "STATUS: " + res.statusCode
    console.log "HEADERS: " + JSON.stringify(res.headers)
    res.setEncoding "utf8"
    res.on "data", (d) ->
      console.info "\n\nPOST completed"
      callback status: "success"

  ).on("error", (e) ->
    callback status: e.message
  )
  
  # write parameters to post body  
  req.write user
  req.end()

exports.Api = Api