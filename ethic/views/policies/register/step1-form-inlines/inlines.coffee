require 'marionette'

# TODO: on enter -> do not submit form

class BaseInline extends Backbone.Marionette.ItemView

  ui:
    input: '.js-input'

  events:
    'change @ui.input': 'onChange'
    'keyup @ui.input': 'onChange'

  onChange: ->
    clearTimeout @_timer
    name = @ui.input.attr 'name'
    val = @ui.input.val()
    @_timer = setTimeout =>
      if @model.set(name, val, validate: true)
        @triggerMethod 'inline:valid'
      else
        @triggerMethod 'inline:invalid', 'errorMessage'  # TODO
    , 500


class Inline0 extends BaseInline

  template: require './inline0.view.html'


class Inline1 extends BaseInline

  template: require './inline1.view.html'


class Inline2 extends BaseInline

  template: require './inline2.view.html'


class Inline3 extends BaseInline

  template: require './inline3.view.html'


class Inline4 extends BaseInline

  template: require './inline4.view.html'


class Inline5 extends BaseInline

  template: require './inline5.view.html'


class Inline6 extends BaseInline

  template: require './inline6.view.html'


module.exports = [
  Inline0, Inline1, Inline2, Inline3,
  Inline4, Inline5, Inline6
]
module.exports.BaseInline = BaseInline
