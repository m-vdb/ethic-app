module.exports = [
  '$routeProvider'
  ($routeProvider) ->
    $routeProvider.when('/',
      controller: 'dashboard'
      template: require('./components/dashboard/dashboard.view.html')
    ).when('/file-claim',
      controller: 'file_claim'
      templateUrl: 'file_claim.html'
    ).when('/register-policy',
      controller: 'register-policy'
      template: require('./components/policies/register.view.html')
    ).otherwise redirectTo: '/'
    return
]
