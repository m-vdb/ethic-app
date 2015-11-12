Policy = require './policy.coffee'


class Member extends Backbone.Model

  validation:

    email:
      pattern: 'email'
      required: true
      msg: 'Please enter a valid email'

    password:
      required: true
      msg: 'Password is required'

  newPolicy: ->
    new Policy
      member: @


module.exports = Member
