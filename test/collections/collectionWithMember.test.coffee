CollectionWithMember = require '../../ethic/collections/collectionWithMember.coffee'


describe 'CollectionWithMember', ->

  describe 'constructor', ->
    it 'should save the member and call the super', ->
      member = new Backbone.Model()
      model = new Backbone.Model()
      col = new CollectionWithMember member, [model]
      expect(col.member).to.be.equal member
      expect(col.models).to.be.like [model]

  describe 'url', ->
    it 'should raise if urlConfigKey missing', ->
      member = new Backbone.Model()
      col = new CollectionWithMember member
      expect(col.url).to.throw Error

    it 'should return the url from the config', ->
      member = new Backbone.Model id: 'some-id'
      class TheCol extends CollectionWithMember
        urlConfigKey: 'api.claims'

      col = new TheCol member
      expect(col.url()).to.be.equal 'http://localhost:1234/members/some-id/claims'
