module.exports = ['$scope', '$location', 'userData', 'networkData', function ($scope, $location, userData, networkData) {

      $scope.user = userData;
      $scope.network = networkData;

      $scope.go = function ( path ) {       // this is to change routes from buttons
        $location.path( path );
      };
}];
