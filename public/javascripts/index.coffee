Index = ->
  initImageUploader()
initImageUploader = ->
  imagePreview = $(".image-preview")
  imageID = $(".image-id")
  $(".cloudinary-fileupload").bind "fileuploadstart", (e) ->
    imagePreview.html "Upload started..."

  
  # Upload finished
  $(".cloudinary-fileupload").bind "cloudinarydone", (e, data) ->
    imagePreview.html $.cloudinary.image(data.result.public_id,
      format: data.result.format
      version: data.result.version
      crop: "scale"
      width: 100
      height: 100
    )
    imageID.val data.result.public_id
    true

$(document).ready ->
  index = new Index()
