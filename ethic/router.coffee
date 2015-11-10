require 'marionette'


class Router extends Backbone.Marionette.AppRouter

  appRoutes:
    "": "onHome"
    "login": "onLogin"
    "policies/register": "onRegisterPolicy"
    "claims/file": "onFileClaim"
    "payment": "onPayment"
    "faq": "onFAQ"
    "tos": "onTOS"



module.exports = Router
