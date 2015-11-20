require 'marionette'
Dropzone = require 'dropzone'
Dropzone.autoDiscover = false


class RegisterPolicyProofView extends Backbone.Marionette.ItemView

  template: require './proof.view.html'
  ui:
    fileUploadContainer: '.js-file-upload-container'
    explanationLink: '.js-explanation-link'
    explanation: '.js-explanation'

  events:
    'click @ui.explanationLink': 'showExplanation'

  onRender: ->
    @dropzone = new Dropzone @ui.fileUploadContainer[0],
      url: @model.proofUrl()
      dictDefaultMessage: 'Click here to select a file or drag\'n\'drop it'
      maxFiles: 1
      paramName: 'proofOfInsurance'
      maxFilesize: 10
      acceptedFiles: 'image/*'
      withCredentials: true
    @dropzone.on 'success', _.bind(@onUploadSuccess, @)
    @dropzone.on 'error', _.bind(@onUploadError, @)

  showExplanation: ->
    @ui.explanation.show()

  onUploadSuccess: ->
    @triggerMethod 'step:over'

  onUploadError: ->
    # TODO:
    console.log 'error...'


module.exports = RegisterPolicyProofView
