module.exports = [
  '$scope', '$sce',
  ($scope, $sce) ->
    $scope.menuBar = $sce.trustAsHtml(require('./menu.view.html'))
    return
]
