require 'marionette'

AuthUtils = require './utils/auth.coffee'


class Router extends Backbone.Marionette.AppRouter

  appRoutes:
    "": "onHome"
    "login": "onLogin"
    "policies/register": "onRegisterPolicy"
    "claims/file": "onFileClaim"
    "payment": "onPayment"
    "faq": "onFAQ"
    "tos": "onTOS"

  route: (route, methodName, method) ->
    decorated = ->
      if route != 'login' and not AuthUtils.isAuthenticated()
        window.location.replace '#login'
      else
        method()
    super route, methodName, decorated


module.exports = Router
