
class Member extends Backbone.Model

  validation:

    email:
      pattern: 'email'
      required: true
      msg: 'Please enter a valid email'

    password:
      required: true
      msg: 'Password is required'


module.exports = Member
