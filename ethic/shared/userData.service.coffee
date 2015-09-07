chance = require('chance')()
moment = require('moment')
module.exports = [
  'CONTRACT_ADDRESS'
  (CONTRACT_ADDRESS) ->
    # FIXME
    #  var contractString = web3.eth.storageAt(CONTRACT_ADDRESS, 0);     // look at the format of extracted data, string or what
    #  var contractString = web3.eth.storageAt(CONTRACT_ADDRESS, 2);     // info about the user and info about the community will be at two different places
    # // what we don't need we should suppress from the contract's storage
    if window.web3
      # TODO
      contractString = web3.eth.getStorageAt(CONTRACT_ADDRESS, 0)
      contractString.profiles['logged_address']
    else
      # TODO: if env = dev?
      num_policies = chance.integer(
        min: 1
        max: 5)
      {
        joining_date: moment.unix(chance.timestamp()).format('MMMM Do YYYY')
        amount_owed: chance.integer(min: 0)
        time_left_to_pay: chance.integer(
          min: 0
          max: 30)
        num_policies: num_policies
        member_policies: chance.n((->
          {
            model: chance.pick([
              'Prius'
              'Camaro'
              'Fixie'
            ])
            date: moment.unix(chance.timestamp()).format('MMMM Do YYYY')
          }
        ), num_policies)
      }
]
