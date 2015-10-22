require 'marionette'
ProgressView = require './progress.view.coffee'

steps = [
  require './step-0.view.coffee'
  require './step-1.view.coffee'
  require './step-2.view.coffee'
  require './step-3.view.coffee'
  require './step-4.view.coffee'
]

class RegisterStepLayout extends Backbone.Marionette.LayoutView

  template: require './step.layout.html'

  regions:
    progress: ".register-policy-progress"
    content: ".register-policy-step-content"

  childEvents:
    'step:over': 'onStepOver'

  initialize: ->
    @currentStepIdx = if @collection.length == 0 then 0 else 1
    @FirstStepView = steps[@currentStepIdx]

  onShow: ->
    @showChildView 'progress', new ProgressView
      model: @model
    @showChildView 'content', new @FirstStepView
      model: @model

  onStepOver: (view, saveModel) ->
    if saveModel
      @model.save null,
        success: _.bind @doNextStep, @
        error: ->
          # TODO
          console.log 'dayum'
    else
      @doNextStep()

  doNextStep: ->
    @currentStepIdx++
    if @currentStepIdx >= steps.length
      # TODO: we're done
    else
      StepView = steps[@currentStepIdx]
      @showChildView 'content', new StepView
        model: @model

module.exports = RegisterStepLayout
