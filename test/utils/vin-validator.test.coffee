VinValidator = require '../../ethic/utils/vin-validator.coffee'


describe 'VinValidator', ->
  beforeEach ->
    @validator = new VinValidator

  describe 'validateLength', ->
    it 'should raise Error if length is > 17', ->
      expect(-> @validator.validateLength 'VOHIHIJ81209BJEWKJEWJEOWJE').to.throw Error

    it 'should raise Error if length is < 17', ->
      expect(-> @validator.validateLength 'IQUGYWBQ').to.throw Error

    it 'should do nothing if length == 17', ->
      expect(@validator.validateLength 'QWERTDHOPOK197JKP').to.be.undefined

  describe '_transliterateLetter', ->
    it 'should change a letter in number', ->
      expect(@validator._transliterateLetter 'D').to.be.equal 4

    it 'should work with numbers', ->
      expect(@validator._transliterateLetter '9').to.be.equal 9

    it 'should raise for bad characters', ->
      expect(=> @validator._transliterateLetter 'I').to.throw Error
      expect(=> @validator._transliterateLetter 'O').to.throw Error
      expect(=> @validator._transliterateLetter 'Q').to.throw Error
      expect(=> @validator._transliterateLetter 'a').to.throw Error

  describe '_transliterate', ->
    it 'should translate a whole string into numbers', ->
      expect(@validator._transliterate 'ABCDEFGHJKLMNPRSTUVWXYZ0123456789').to.be.like [
        1, 2, 3, 4, 5, 6, 7, 8,
        1, 2, 3, 4, 5, 7, 9,
        2, 3, 4, 5, 6, 7, 8, 9,
        0, 1, 2, 3, 4, 5, 6, 7, 8, 9
      ]

    it 'should raise Error if bad letter', ->
      expect(=> @validator._transliterate 'QOPQIWOQBUWH').to.throw Error

  describe 'validateWMI', ->
    it 'should raise if WMI is not in list', ->
      expect(=> @validator.validateWMI 'WPQ').to.throw Error

    it 'should return undefined otherwise', ->
      expect(@validator.validateWMI '2GT').to.be.undefined

  describe 'decodeYear', ->
    it 'should return a year a year between 1980,2009 if 7th digit is numeric', ->
      expect(@validator.decodeYear 'AAAAAA7AADAAAAAAA').to.be.equal 1983

    it 'should return a year a year between 2010,2039 if 7th digit is not numeric', ->
      expect(@validator.decodeYear 'AAAAAAGAA4AAAAAAA').to.be.equal 2034

    it 'should raise Error if the 10th digit has a bad value', ->
      expect(=> @validator.decodeYear 'AAAAAAAAAIAAAAAAA').to.throw Error
      expect(=> @validator.decodeYear 'AAAAAAAAAOAAAAAAA').to.throw Error
      expect(=> @validator.decodeYear 'AAAAAAAAAQAAAAAAA').to.throw Error
      expect(=> @validator.decodeYear 'AAAAAAAAAUAAAAAAA').to.throw Error
      expect(=> @validator.decodeYear 'AAAAAAAAAZAAAAAAA').to.throw Error
      expect(=> @validator.decodeYear 'AAAAAAAAA0AAAAAAA').to.throw Error

  describe 'validateMaxYear', ->
    it 'should return undefined if no maxYear is set', ->
      expect(@validator.validateMaxYear 2010).to.be.undefined

    it 'should return undefined if validation passed', ->
      validator = new VinValidator maxYear: 2015
      expect(validator.validateMaxYear 2010).to.be.undefined

    it 'should raise error otherwise', ->
      validator = new VinValidator maxYear: 2015
      expect(-> validator.validateMaxYear(2020)).to.throw Error

  describe 'validateMinYear', ->
    it 'should return undefined if no minYear is set', ->
      expect(@validator.validateMinYear 2010).to.be.undefined

    it 'should return undefined if validation passed', ->
      validator = new VinValidator minYear: 2015
      expect(validator.validateMinYear 2015).to.be.undefined

    it 'should raise error otherwise', ->
      validator = new VinValidator minYear: 2015
      expect(-> validator.validateMinYear(2014)).to.throw Error

  describe 'validateDigit', ->
    it 'should work with a real VIN, digit is X', ->
      expect(@validator.validateDigit '1M8GDM9AXKP042788').to.be.undefined

    it 'should work with a real VIN, normal', ->
      expect(@validator.validateDigit '5GZCZ43D13S812715').to.be.undefined

    it 'should raise Error if incorrect VIN', ->
      expect(=> @validator.validateDigit 'SGZCZ43D13S812715').to.be.throw Error

    it 'should raise Error for Porsche Image', ->
      expect(=> @validator.validateDigit 'WP0ZZZ99ZTS392124').to.be.throw Error

    it 'should raise Error for GMT Body', ->
      expect(=> @validator.validateDigit 'KLATF08Y1VB363636').to.be.throw Error

  describe '_validate', ->
    it 'should raise if value is not a string', ->
      expect(=> @validator._validate 1337).to.throw Error

    it 'should set value to uppercase', ->
      expect(@validator._validate '5gzcz43d13s812715').to.be.undefined

    it 'should return undefined in case of success', ->
      expect(@validator._validate '5GZCZ43D13S812715').to.be.undefined

    it 'should raise for incorrect length', ->
      expect(=> @validator._validate '1337').to.throw Error

    it 'should validate digit', ->
      expect(=> @validator._validate '10TAAAAAAAAAAAAAA').to.throw Error

    it 'should validate WMI', ->
      expect(=> @validator._validate 'FBIAAAAAAAAAAAAAA').to.throw Error

    it 'should validate min year', ->
      validator = new VinValidator minYear: 2015
      expect(=> validator._validate '5GZCZ43D13S812715').to.throw Error

    it 'should validate max year', ->
      validator = new VinValidator maxYear: 1980
      expect(=> validator._validate '5GZCZ43D13S812715').to.throw Error

  describe 'validate', ->
    it 'should return undefined for success', ->
      expect(@validator.validate '5GZCZ43D13S812715').to.be.undefined

    it 'should return the error message otherwise', ->
      expect(@validator.validate 'FBIAAAAAAAAAAAAAA').to.be.equal 'Invalid VIN'

  describe 'constructor', ->
    it 'should accept message overrides', ->
      validator = new VinValidator
        messages:
          default: 'BOOM'
      expect(validator.validate 'FBIAAAAAAAAAAAAAA').to.be.equal 'BOOM'
