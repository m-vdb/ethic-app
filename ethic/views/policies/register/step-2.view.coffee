require 'marionette'
Dropzone = require 'dropzone'
Dropzone.autoDiscover = false

class Step2RegisterPolicyView extends Backbone.Marionette.ItemView

  template: require './step-2.view.html'
  ui:
    fileUploadContainer: '.js-file-upload-container'
    explanationLink: '.js-explanation-link'
    explanation: '.js-explanation'

  events:
    'click @ui.explanationLink': 'showExplanation'

  onRender: ->
    @dropzone = new Dropzone @ui.fileUploadContainer[0],
      url: "/file/post"  # TODO
      dictDefaultMessage: 'Click here to select a file or drag\'n\'drop it'
      maxFiles: 1
      addRemoveLinks: true
      paramName: 'proofOfInsurance'
      maxFilesize: 10
      acceptedFiles: 'image/*'

  showExplanation: ->
    @ui.explanation.show()

module.exports = Step2RegisterPolicyView
