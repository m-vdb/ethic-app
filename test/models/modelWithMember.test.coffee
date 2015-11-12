ModelWithMember = require '../../ethic/models/modelWithMember.coffee'


describe 'ModelWithMember', ->

  describe 'constructor', ->
    it 'should save the member and call the super', ->
      member = new Backbone.Model()
      model = new ModelWithMember member: member
      expect(model.get 'member').to.be.equal member

    it 'should raise Error if missing member', ->
      expect(-> new ModelWithMember).to.throw Error

  describe 'url', ->
    it 'should raise if urlConfigKey missing', ->
      member = new Backbone.Model()
      model = new ModelWithMember member: member
      expect(model.url).to.throw Error

    it 'should return the url from the config', ->
      member = new Backbone.Model id: 'some-id'
      class TheModel extends ModelWithMember
        urlConfigKey: 'api.policies'

      model = new TheModel member: member
      expect(model.url()).to.be.equal 'http://localhost:1234/members/some-id/policies'

  describe 'toJSON', ->
    it 'should return the json without the member', ->
      member = new Backbone.Model()
      model = new ModelWithMember
        member: member
        key: 'value'
        name: 'john'

      expect(model.toJSON()).to.be.like
        key: 'value'
        name: 'john'
