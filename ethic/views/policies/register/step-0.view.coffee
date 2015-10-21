Form = require '../form.coffee'

class RegisterPolicyView extends Form

  template: require './register.view.html'

  ui:
    carMakeControl: '.form-control[name=car_make]'
    carModelControl: '.form-control[name=car_model]'

  events:
    'change @ui.carMakeControl': 'handleCarModelControl'

  handleCarModelControl: ->
    if @ui.carMakeControl.val()
      @ui.carModelControl.removeAttr 'disabled'
    else
      @ui.carModelControl.val ''
      @ui.carModelControl.attr 'disabled', 'disabled'


module.exports = RegisterPolicyView
