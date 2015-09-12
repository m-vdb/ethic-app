require 'backbone.marionette'


class Router extends Backbone.Marionette.AppRouter

  appRoutes:
    "": "onHome"
    "policies/register": "onRegisterPolicy"
    "claims": "onClaims"
    "payment": "onPayment"
    "faq": "onFAQ"
    "tos": "onTOS"



module.exports = Router
