# This is a manifest file that'll be compiled into including all the files listed below.
# Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
# be included in the compiled file accessible from http://example.com/assets/application.js
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
#= require jquery
#= require jquery_ujs
#= require loadjs
#= require twitter/bootstrap
#= require oauth.min
#= require_tree .

load
  controllers:
    "application": ['index']
, (controller, action) ->

  access_token = ''

  addPhotos = (photos) ->
    $('#photos').empty()
    $.each(photos, (index, photo) ->
      $('#photos').append(
        '<div class="col-sm-3">
          <img src="' + photo.prefix + photo.width + 'x' + photo.height + photo.suffix + '" alt="">
        </div>'
      )
    )

  getAndAddPhotos = () ->
    $.ajax({
      url: "https://api.foursquare.com/v2/venues/4e6cf4e0c65be8702b08a6dc/photos?v=20141121&m=foursquare&oauth_token=" + access_token
    }).done(( data ) ->
      console.log data
      addPhotos( data.response.photos.items )
    )

  getHereAndNow = () ->
    $.ajax({
      url: "https://api.foursquare.com/v2/venues/4e6cf4e0c65be8702b08a6dc/stats?v=20141121&m=foursquare&oauth_token=" + access_token
    }).done(( data ) ->
      console.log data
    )

  OAuth.initialize('JFBnz9FBunuP8GFaCrfwNvZ-9Qg')
  OAuth.popup('foursquare').done((result) ->
    access_token = result.access_token
    # getAndAddPhotos()
    getHereAndNow()

  )
