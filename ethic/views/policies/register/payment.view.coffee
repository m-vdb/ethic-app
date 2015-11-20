require 'marionette'


class RegisterPolicyPaymentView extends Backbone.Marionette.ItemView

  template: require './payment.view.html'

  ui:
    number: '[data-stripe=number]'
    cvc: '[data-stripe=cvc]'
    exp: '[data-stripe=exp]'
    errorList: '.form-error-list'
    submit: '.btn-submit'

  events:
    'keyup @ui.number': 'onChange'
    'keyup @ui.cvc': 'onChange'
    'keyup @ui.exp': 'onChange'
    'click @ui.submit': 'onSubmit'

  initialize: ->
    member = @model.get 'member'  # we have a policy here
    @stripeCard = member.newStripeCard()
    @listenTo @stripeCard, 'stripe:success', @onSuccess
    @listenTo @stripeCard, 'stripe:error', @onError

  onShow: ->
    @ui.exp.payment 'formatCardExpiry'
    Backbone.Validation.bind @,
      model: @stripeCard
      valid: @onValid
      invalid: @onInvalid

  onChange: (e) ->
    clearTimeout @_timer
    $target = $(e.target)
    @_timer = setTimeout =>
      @stripeCard.set($target.data('stripe'), $target.val(), validate: true)
    , 500

  onValid: (view, attr) ->
    $(".error-#{attr}", view.ui.errorList).remove()
    if view.stripeCard.isValid()
      view.ui.submit.removeAttr 'disabled'

  onInvalid: (view, attr, error) ->
    $(".error-#{attr}", view.ui.errorList).remove()  # do not duplicate errors
    view.ui.errorList.append "<li class='error-#{attr}'>#{ error }</li>"
    view.ui.submit.attr 'disabled', 'disabled'

  onSubmit: (e) ->
    e.preventDefault()
    e.stopPropagation()
    return if @ui.submit.attr 'disabled' or not @stripeCard.isValid()
    @stripeCard.save()

  clearErrors: ->
    @ui.errorList.html ''

  onSuccess: ->
    @triggerMethod 'step:over'

  onError: (error = "An error occurred, please try a again.") ->
    @ui.errorList.append "<li class='error-server'>#{ error }</li>"


module.exports = RegisterPolicyPaymentView
