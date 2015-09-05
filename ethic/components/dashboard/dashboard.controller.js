module.exports = ['$scope', '$location', function ($scope, $location) {          // creates a controller
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
}];
