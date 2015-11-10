config = require '../config.coffee'


class AuthUtils

  checkUrl: config.get('ethic_backend.base_url')

  onError: (errorThrown) ->
    switch errorThrown
      when "Unauthorized" then window.location.replace('#login')
      when "Forbidden" then window.location.replace('#login')
    # TODO: else

  checkAuthentication: (callback) ->
    $.ajax
      url: @checkUrl
      success: callback
      error: (jqXHR, textStatus, errorThrown) =>
        @onError(errorThrown)
        callback()


module.exports = new AuthUtils()
