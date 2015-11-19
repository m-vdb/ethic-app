require 'jquery.payment'

ModelWithMember = require './modelWithMember.coffee'
config = require '../config.coffee'
paymentValidator = require '../utils/payment-validator.coffee'


class StripeCard extends ModelWithMember

  urlConfigKey: 'api.stripeCustomer'

  validation:

    number:
      required: true
      fn: paymentValidator.makeValidator($.payment.validateCardNumber, 'Invalid card number')

    cvc:
      required: true
      fn: paymentValidator.makeValidator($.payment.validateCardCVC, 'Invalid card CVC')

    exp:
      required: true
      fn: (value) ->
        return unless value
        exp = $.payment.cardExpiryVal value
        if not $.payment.validateCardExpiry exp.month, exp.year
          return 'Invalid expiration date.'

  initialize: ->
    if not Stripe.key
      Stripe.setPublishableKey config.get('stripe.publicKey')

  save: ->
    if @isValid(true)
      Stripe.card.createToken @toJSON(), _.bind(@saveHandler, @)

  saveHandler: (status, response) ->
    if response.error
      @trigger 'stripe:error', response.error.message
    else
      @set 'token', response.id
      $.ajax
        type: 'POST'
        url: @url()
        data: JSON.stringify(stripeToken: response.id)
        contentType: "application/json"
        dataType: "json"
      .done _.bind(@onSaveSuccess, @)
      .fail _.bind(@onSaveError, @)

  onSaveSuccess: ->
    @trigger 'stripe:success'

  onSaveError: ->
    @trigger 'stripe:error'


_.extend StripeCard.prototype, Backbone.Validation.mixin
module.exports = StripeCard
