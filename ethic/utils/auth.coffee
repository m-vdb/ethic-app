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

  isAuthenticated: ->
    @member and @member.id?

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

  authenticate: (data, onError) ->
    $.ajax
      type: 'POST'
      url: @authenticateUrl
      data: JSON.stringify(data)
      contentType: 'application/json'
      dataType: "json"
      error: onError
      success: (data) =>
        @member.set data
        window.location.replace '#'

module.exports = AuthUtils.get()
