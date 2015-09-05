var myApp = angular.module('myApp', ['ngRoute']);   // creates a module
  //  var contractString = web3.eth.storageAt(contract_address, 0);     // look at the format of extracted data, string or what
  //  var contractString = web3.eth.storageAt(contract_address, 2);     // info about the user and info about the community will be at two different places
  // // what we don't need we should suppress from the contract's storage

    myApp.config(function($routeProvider){
      $routeProvider
        .when('/',
          {
            controller:'storage'
            ,templateUrl : 'user_dashboard.html'
          })
        .when('/file_claim',
          {
            controller:'file_claim'
            ,templateUrl : 'file_claim.html'
          })
        .when('/register_policy',
          {
            controller:'register_policy'
            ,templateUrl : 'register_policy.html'
          })
      //  .otherwise({redirectTo:'/view1'});


    });



    myApp.controller('storage', function($scope, $location){          // creates a controller
    /*
      $scope.joining_date = contractString.profiles['logged_address'].joining_date;           //user
      $scope.num_of_members = contractString.profiles['logged_address'].num_of_members;         //network
      $scope.number_claims_handled = contractString.profiles['logged_address'].number_claims_handled;   //network
      $scope.amount_owed = contractString.profiles['logged_address'].amount_owed;             //user
      $scope.time_left_to_pay = contractString.profiles['logged_address'].time_left_to_pay;       //user
      $scope.num_policies = contractString.profiles['logged_address'].num_policies;           //user

      var my_policies = contractString.members['logged_address'].member_policies;
      var policies_array = [];

      for (i=0; i<$scope.num_policies; i++0) {
         policies_array[i] = my_policies[i];
         }
      $scope.policies = policies_array;
    */

      $scope.tttt = "policy 1";

      $scope.go = function ( path ) {       // this is to change routes from buttons
        $location.path( path );
      };



    });



    myApp.controller('file_claim', function($scope, $location){
  /*
      $scope.amount_claimed = 0 ;
      $scope.policy_id = null ;
      $scope.claim = function(){
        var amount_claimed = $scope.amount_claimed;
        var policy_id = $scope.policy_id;

        if (amount_claimed != 0){       // this is to ensure that he does not claim zero, not solid enough but will be stronger later
          web3.eth.sendTransaction({to: contract_address, data:
            ABI_4bytes_function_add_claim,
            amount_claimed,
            policy_id,                  // in case he has several cars, he can chose one of his contracts
            function(err, address) {
                if (!err)
                console.log(address);
              };
            });

        // here add a function which sends this claim to the claim auditors!!!maybe with selecting a random one or something else with geolocation

        }
      }
  */  });



    myApp.controller('register_policy', function($scope, $location){
  /*
      $scope.car_year = null;       // initialization, maybe not necessary
      $scope.car_model = null;
      $scope.initial_premium = null;
      $scope.initial deductible = null;
      // $scope.policy_type = null;

      $scope.register_policy = function(){
        var car_year = $scope.car_year;
        var car_model = $scope.car_model;
        var initial_premium = $scope.initial_premium;
        var initial_deductible = $scope.initial;
        // var policy_type = $scope.policy_type;    depending on the policy type, we might have to send the transacton to a different contract if we want one contract per policy type, see with storage capabilities
        web3.eth.sendTransaction({to: contract_address, data:
        ABI_4bytes_function_add_policy,
        car_year,
        car_model,
        initial_premium,
        initial_deductible,
        function(err, address) {
            if (!err)
            console.log(address); // "0x7f9fade1c0d57a7af66ab4ead7c2eb7b11a91385"
          };
        });
      }
  */  });



    myApp.controller('auditor_backoffice', function($scope, $location){   // function called by the auditor peer from his backoffice
  /*
      $scope.claim_id = null;
      $scope.amount_awarded = null;

      $scope.register_policy = function(){
        var claim_id = $scope.claim_id;
        var amount_awarded = $scope.amount_awarded;
        web3.eth.sendTransaction({to: contract_address, data:
          ABI_4bytes_function_award_claim,
          claim_id,
          function(err, address) {
              if (!err)
              console.log(address);
          }
        });
      }
  */  });



    myApp.controller('payment_page', function($scope, $location){     // a voir si on facture en ether ou si on toruve un truc simple pour paiement en dollar, ici c'est pour ether

  /*
      $scope.pay_what_I_owe = function(){
      balance = web3.eth.balanceAt(logged_address);
        if (balance > amount_owed) {
        web3.eth.sendTransaction({to: contract_address, amount = amount_owed}) ;   // add gas etc
          };
        else {
          alert("Your account has insufficient funds. Please move funds onto your account and try again.");
          }
      }
  */  });


// register new member --> when he comes on the paltform and can provide an identification code and a password that we gave to him over his tradition browser (joinethic.com) (?)

// verify_identity();       // use the process written down, also this function is to verify who the user is and get the profile's address, musr return address_logged so since this function is in the same script we can get its returned value
              // !!! this is simply when he logs, to see if we know him or not
// give_acceptance      // later, when critical size and peers can invite sb

