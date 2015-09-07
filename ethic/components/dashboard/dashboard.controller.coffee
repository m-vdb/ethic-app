module.exports = [
  '$scope', '$location', 'userData', 'networkData',
  ($scope, $location, userData, networkData) ->
    $scope.user = userData
    $scope.network = networkData

    $scope.go = (path) ->
      # this is to change routes from buttons
      $location.path path
      return

    return
]
