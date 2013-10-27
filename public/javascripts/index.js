// Generated by CoffeeScript 1.3.3
(function() {
  var Index, initImageUploader;

  Index = function() {
    return initImageUploader();
  };

  initImageUploader = function() {
    var imageID, imagePreview;
    imagePreview = $(".image-preview");
    imageID = $(".image-id");
    $(".cloudinary-fileupload").bind("fileuploadstart", function(e) {
      return imagePreview.html("Upload started...");
    });
    return $(".cloudinary-fileupload").bind("cloudinarydone", function(e, data) {
      imagePreview.html($.cloudinary.image(data.result.public_id, {
        format: data.result.format,
        version: data.result.version,
        crop: "scale",
        width: 100,
        height: 100
      }));
      imageID.val(data.result.public_id);
      return true;
    });
  };

  $(document).ready(function() {
    var index;
    return index = new Index();
  });

}).call(this);
