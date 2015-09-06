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
    return {
      number_of_members: chance.integer({min: 0}),
      number_claims_handled: chance.integer({min: 0}),
      number_policies: chance.integer({min: 0})
    };
  }
}];
