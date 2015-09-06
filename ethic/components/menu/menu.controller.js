module.exports = ['$scope', '$sce', function ($scope, $sce) {
  $scope.menuBar = $sce.trustAsHtml(require('./menu.view.html'));
}];
