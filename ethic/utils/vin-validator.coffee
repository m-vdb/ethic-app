
class VinValidator

  defaultMessages:
    default: "Invalid VIN"
    minYear: "Car year is too old."
    maxYear: "Car year is too recent."

  constructor: (options={}) ->
    @messages = _.extend @defaultMessages, options.messages
    if options.minYear
      @minYear = options.minYear
    if options.maxYear
      @maxYear = options.maxYear

  validate: (value) ->
    try
      @_validate value
    catch error
      return error.message

  _validate: (value) ->
    throw new Error('VIN should be a string') unless _.isString(value)
    value = value.toUpperCase()
    @validateLength value
    @validateDigit value
    @validateWMI value

    year = @decodeYear value
    @validateMinYear year
    @validateMaxYear year

  validateLength: (value) ->
    throw new Error(@messages.default) unless value.length == 17

  validateDigit: (value) ->
    # https://en.wikipedia.org/wiki/Vehicle_identification_number#Check_digit_calculation
    digits = @_transliterate value
    products = _.map digits, (digit, idx) ->
      digit * digitWeights[idx]
    sum = _.reduce products, (m, d) ->
      m + d
    remainder = sum % 11
    if remainder == 10
      remainder = 'X'
    digit = remainder.toString()
    throw new Error(@messages.default) unless digit == value[8]

  _transliterate: (value) ->
    _.map value, @_transliterateLetter, @

  _transliterateLetter: (letter) ->
    digit = transliterationMap[letter]
    throw new Error(@messages.default) unless digit?
    digit

  validateWMI: (value) ->
    # http://www.autocalculator.org/VIN/WMI.aspx
    wmi = value.substring 0, 3
    throw new Error(@messages.default) unless _.contains(wmiList, wmi)

  validateMinYear: (year) ->
    return unless @minYear
    throw new Error(@messages.minYear) unless year >= @minYear

  validateMaxYear: (year) ->
    return unless @maxYear
    throw new Error(@messages.maxYear) unless year <= @maxYear

  decodeYear: (value) ->
    # https://en.wikipedia.org/wiki/Vehicle_identification_number#Model_year_encoding
    yearDigit = value[9]  # 10th digit
    helperDigit = value[6]  # 7th digit
    helperDigitIsNumeric = not isNaN(parseInt helperDigit, 10)
    yearParts = yearMap[yearDigit]

    throw new Error(@messages.default) unless yearParts
    return if helperDigitIsNumeric then yearParts[0] else yearParts[1]


transliterationMap =
  A: 1
  B: 2
  C: 3
  D: 4
  E: 5
  F: 6
  G: 7
  H: 8
  J: 1
  K: 2
  L: 3
  M: 4
  N: 5
  P: 7
  R: 9
  S: 2
  T: 3
  U: 4
  V: 5
  W: 6
  X: 7
  Y: 8
  Z: 9
  1: 1
  2: 2
  3: 3
  4: 4
  5: 5
  6: 6
  7: 7
  8: 8
  9: 9
  0: 0

digitWeights =
  0: 8
  1: 7
  2: 6
  3: 5
  4: 4
  5: 3
  6: 2
  7: 10
  8: 0
  9: 9
  10: 8
  11: 7
  12: 6
  13: 5
  14: 4
  15: 3
  16: 2

yearMap =
  A: [1980, 2010]
  B: [1981, 2011]
  C: [1982, 2012]
  D: [1983, 2013]
  E: [1984, 2014]
  F: [1985, 2015]
  G: [1986, 2016]
  H: [1987, 2017]
  J: [1988, 2018]
  K: [1989, 2019]
  L: [1990, 2020]
  M: [1991, 2021]
  N: [1992, 2022]
  P: [1993, 2023]
  R: [1994, 2024]
  S: [1995, 2025]
  T: [1996, 2026]
  V: [1997, 2027]
  W: [1998, 2028]
  X: [1999, 2029]
  Y: [2000, 2030]
  1: [2001, 2031]
  2: [2002, 2032]
  3: [2003, 2033]
  4: [2004, 2034]
  5: [2005, 2035]
  6: [2006, 2036]
  7: [2007, 2037]
  8: [2008, 2038]
  9: [2009, 2039]

wmiList = [
  "10T","11V","137","15G","17N","18X","19U","1A4","1A8","1AC","1AM","1B3","1B4",
  "1B6","1B7","1B7","1BA","1BB","1BD","1C3","1C4","1C8","1C9","1CY","1D3","1D4","1D5",
  "1D7","1D8","1EC","1F1","1F6","1FA","1FB","1FC","1FD","1FE","1FM","1FT","1FU","1FV",
  "1G1","1G2","1G3","1G4","1G5","1G6","1G8","1GA","1GB","1GC","1GD","1GE","1GF","1GG",
  "1GH","1GJ","1GK","1GM","1GN","1GT","1GY","1HG","1HS","1HT","1HV","1J4","1J7","1J8",
  "1JC","1JD","1JT","1L1","1LN","1M1","1M2","1M3","1M8","1ME","1MR","1N4","1N6","1N9",
  "1NK","1NP","1NX","1P3","1P4","1P7","1P9","1RF","1S9","177","1T8","1TU","1V1","1VW",
  "1WA","1WB","1WU","1WV","1XK","1XM","1XP","1Y1","1YV","1Z3","1Z5","1Z7","1ZV","1ZW",
  "2A3","2A4","2A8","2B1","2B3","2B4","2B5","2B6","2B7","2B8","2BC","2C1","2C3","2C4",
  "2C7","2C8","2CC","2CK","2CM","2CN","2D4","2D6","2D7","2D8","2E3","2FA","2FD","2FM",
  "2FT","2FU","2FV","2FW","2FZ","2G0","2G1","2G2","2G3","2G4","2G5","2G7","2G8","2GA",
  "2GB","2GD","2GJ","2GK","2GN","2GT","2HG","2HH","2HJ","2HK","2HM","2HN","2HS","2HT",
  "2J4","2LM","2M2","2ME","2MH","2MR","2NK","2NP","2P3","2P4","2P5","2P9","2PC","2S2",
  "2S3","2T1","2T2","2WK","2WL","2XK","2XM","2XP","3A4","3A8","3AB","3AL","3B3","3B4",
  "3B6","3B7","3BK","3BP","3C3","3C4","3C8","3CA","3D3","3D5","3D6","3D7","3FA","3FC",
  "3FD","3FE","3FR","3FT","3G1","3G2","3G4","3G5","3G7","3GB","3GC","3GD","3GE","3GK",
  "3GN","3GT","3GY","3HA","3HG","3HM","3HS","3HT","3LN","3MA","3ME","3N1","3NK","3NM",
  "3P3","3TM","3VW","3WK","45V","46G","49H","4A3","4A4","4B3","4C3","4CD","4DR","4E3",
  "4F2","4F4","4G1","4G2","4GD","4GT","4JG","4KB","4KD","4KL","4M2","4N1","4N2","4NU",
  "4P3","4S1","4S2","4S3","4S4","4S6","4S7","4SL","4T1","4T3","4TA","4US","4UZ","4V1",
  "4V2","4V4","4V5","4VA","4VG","4VH","4VL","4VM","4VZ","5AS","5B4","5CK","5FN","5FY",
  "5GA","5GR","5GT","5GZ","5J6","5J8","5KJ","5KK","5LM","5LT","5N1","5N3","5NM","5NP",
  "5PV","5S3","5SX","5T4","5TB","5TD","5TE","5TF","5UM","5UX","5Y2","6G2","6MM","6MP",
  "9BF","9BW","9DW","J81","J87","J8B","J8D","J8Z","JA3","JA4","JA7","JAA","JAB","JAC",
  "JAE","JAL","JB3","JB4","JB7","JC2","JD1","JD2","JE3","JF1","JF2","JF3","JF4","JG1",
  "JG7","JGC","JH4","JHB","JHL","JHM","JJ3","JL6","JLS","JM1","JM2","JM3","JN1","JN3",
  "JN4","JN6","JN8","JNA","JNK","JNR","JNX","JP3","JP4","JP7","JR2X","JS2","JS3","JS4",
  "JT2","JT3","JT4","JT5","JT6","JT8","JTD","JTE","JTH","JTJ","JTK","JTL","JTM","JTN",
  "JW6","JW7","KL1","KL2","KL5","KL7","KLA","KM8","KMF","KMH","KNA","KND","KNJ","KPH",
  "LES","LM5","ML3","SA9","SAJ","SAL","SAT","SAX","SCA","SCB","SCC","SCF","SDL","SHH",
  "SHS","SJN","TRU","VF1","VF7","VF3","VG6","VSS","W06","WA1","WAU","WBA","WBS","WBX",
  "WD0","WD1","WD2","WD5","WD8","WDB","WDC","WDD","WDP","WDX","WDY","WF1","WKK","WME",
  "WMW","WP0","WP1","WUA","WV2","WV3","WVG","WVW","XTA","YB3","YS3","YV1","YV2","YV4",
  "YV5","ZA9","ZAM","ZAR","ZC2","ZFA","ZFF","ZHW"
]


module.exports = VinValidator
