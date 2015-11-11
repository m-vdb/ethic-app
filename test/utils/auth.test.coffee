AuthUtils = require '../../ethic/utils/auth.coffee'


describe 'AuthUtils', ->

  beforeEach ->
    @$ajax = @sinon.stub $, 'ajax'

  afterEach ->
    delete AuthUtils.member

  describe 'constructor', ->
    it 'should call $.ajaxSetup', ->
      expect($.ajaxSetup()['xhrFields']).to.be.like withCredentials: true
      expect($.ajaxSetup()['crossDomain']).to.be.equal true

  describe 'setMember', ->
    it 'should set member on the AuthUtils', ->
      member = new Backbone.Model
      AuthUtils.setMember member
      expect(AuthUtils.member).to.be.equal member

  describe 'isAuthenticated', ->
    it 'should return false if no member on the instance', ->
      expect(AuthUtils.isAuthenticated()).to.be.not.ok

    it 'should return false if no member id', ->
      member = new Backbone.Model
      AuthUtils.setMember member
      expect(AuthUtils.isAuthenticated()).to.be.not.ok

    it 'should return true otherwise', ->
      member = new Backbone.Model id: 'some-id'
      AuthUtils.setMember member
      expect(AuthUtils.isAuthenticated()).to.be.ok

  describe 'onCheckError', ->
    it 'should redirect to #login on Unauthorized', ->
      @sinon.stub window.location, 'replace'
      AuthUtils.onCheckError 'Unauthorized'
      expect(window.location.replace).to.have.been.calledWith '#login'

    it 'should redirect to #login on Forbidden', ->
      @sinon.stub window.location, 'replace'
      AuthUtils.onCheckError 'Forbidden'
      expect(window.location.replace).to.have.been.calledWith '#login'

  describe 'checkAuthentication', ->
    it 'should call memberUrl, set data on member and call callback on success', ->
      member = new Backbone.Model
      AuthUtils.setMember member
      cb = @sinon.spy()
      @$ajax.yieldsTo 'success',
        id: 'some-id'
        name: 'jean-louis'
      AuthUtils.checkAuthentication cb

      expect(@$ajax).to.have.been.calledWithMatch url: 'http://localhost:1234/member'
      expect(member.attributes).to.be.like
        id: 'some-id'
        name: 'jean-louis'
      expect(cb).to.have.been.called

    it 'should call memberUrl, call onCheckError and call callback on error', ->
      member = new Backbone.Model
      AuthUtils.setMember member
      cb = @sinon.spy()
      @sinon.stub AuthUtils, 'onCheckError'
      @$ajax.yieldsTo 'error', null, null, 'Forbidden'
      AuthUtils.checkAuthentication cb

      expect(@$ajax).to.have.been.calledWithMatch url: 'http://localhost:1234/member'
      expect(member.attributes).to.be.like {}
      expect(AuthUtils.onCheckError).to.have.been.calledWith 'Forbidden'
      expect(cb).to.have.been.called

    it 'should raise error if no member on the instance', ->
      expect(AuthUtils.checkAuthentication).to.throw Error

  describe 'authenticate', ->
    it 'should call authenticateUrl, set data on member and redirect to home on success', ->
      member = new Backbone.Model
      AuthUtils.setMember member
      cb = @sinon.spy()
      @sinon.stub window.location, 'replace'
      @$ajax.yieldsTo 'success',
        id: 'some-id'
        name: 'jean-louis'
      data =
        email: 'g@g.com'
        password: 'some-pw'
      AuthUtils.authenticate data, cb

      expect(@$ajax).to.have.been.calledWithMatch
        url: 'http://localhost:1234/authenticate'
        type: 'POST'
        data: JSON.stringify(data)
        contentType: 'application/json'
        dataType: "json"
      expect(member.attributes).to.be.like
        id: 'some-id'
        name: 'jean-louis'
      expect(window.location.replace).to.have.been.calledWith '#'
      expect(cb).to.not.have.been.called

    it 'should call authenticateUrl and call the error callback on error', ->
      member = new Backbone.Model
      AuthUtils.setMember member
      cb = @sinon.spy()
      @sinon.stub window.location, 'replace'
      @$ajax.yieldsTo 'error', 'jqXHR', 'textStatus', 'Unauthorized'
      data =
        email: 'g@g.com'
        password: 'some-pw'
      AuthUtils.authenticate data, cb

      expect(@$ajax).to.have.been.calledWithMatch
        url: 'http://localhost:1234/authenticate'
        type: 'POST'
        data: JSON.stringify(data)
        contentType: 'application/json'
        dataType: "json"
      expect(member.attributes).to.be.like {}
      expect(window.location.replace).to.not.have.been.called
      expect(cb).to.have.been.calledWith 'jqXHR', 'textStatus', 'Unauthorized'

    it 'should raise error if no member on the instance', ->
      expect(-> AuthUtils.checkAuthentication {}, @sinon.spy()).to.throw Error
