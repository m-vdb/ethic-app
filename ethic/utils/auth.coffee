config = require '../config.coffee'


class AuthUtils

  memberUrl: config.get('api.member')
  authenticateUrl: config.get('api.authenticate')

  @get: ->
    if not @instance?
      instance = new @

    instance

  constructor: ->
    $.ajaxSetup
      xhrFields:
        withCredentials: true
      crossDomain: true

  setMember: (member) ->
    @member = member

  onCheckError: (errorThrown) ->
    switch errorThrown
      when "Unauthorized" then window.location.replace('#login')
      when "Forbidden" then window.location.replace('#login')
    # TODO: else

  checkAuthentication: (callback) ->
    $.ajax
      url: @memberUrl
      success: (data) =>
        @member.set data
        callback()
      error: (jqXHR, textStatus, errorThrown) =>
        @onCheckError(errorThrown)
        callback()

  authenticate: (data) ->
    $.ajax
      type: 'POST'
      url: @authenticateUrl
      data: JSON.stringify(data)
      contentType: 'application/json'
      dataType: "json"
      success: (data) =>
        @member.set data
        window.location.replace '#'

module.exports = AuthUtils.get()
