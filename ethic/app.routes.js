module.exports = ['$routeProvider', function ($routeProvider){
  $routeProvider
    .when('/', {
      controller: 'dashboard',
      template: require('./components/dashboard/dashboard.view.html')
    })
    .when('/file-claim', {
      controller:'file_claim',
      templateUrl : 'file_claim.html'
    })
    .when('/register_policy', {
      controller:'register_policy',
      templateUrl : 'register_policy.html'
    })
    .otherwise({redirectTo: '/'});
}];
