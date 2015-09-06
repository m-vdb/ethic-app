var chance = require('chance')();

module.exports = ['CONTRACT_ADDRESS', function (CONTRACT_ADDRESS) {
  // FIXME
  //  var contractString = web3.eth.storageAt(CONTRACT_ADDRESS, 0);     // look at the format of extracted data, string or what
  //  var contractString = web3.eth.storageAt(CONTRACT_ADDRESS, 2);     // info about the user and info about the community will be at two different places
  // // what we don't need we should suppress from the contract's storage

  if (window.web3) {
    // TODO
    var contractString = web3.eth.storageAt(CONTRACT_ADDRESS, 0);
    return contractString.profiles['logged_address'];
  }
  else {  // TODO: if env = dev?
    var num_policies = chance.integer({min: 1, max: 5});
    return {
      joining_date: chance.timestamp(),
      amount_owed: chance.integer({min: 0}),
      time_left_to_pay: chance.integer({min: 0, max: 30}),
      num_policies: chance.integer({min: 1, max: 5}),
      member_policies: chance.n(function () {
        return {
          model: chance.pick(['Prius', 'Camaro', 'Fixie']),
          date: chance.timestamp()
        };
      }, num_policies)
    };
  }
}];
