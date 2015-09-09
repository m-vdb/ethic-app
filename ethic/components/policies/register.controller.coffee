module.exports = [
  '$scope', 'CONTRACT_ADDRESS', 'carData',
  ($scope, CONTRACT_ADDRESS, carData) ->
    $scope.formData = {}
    $scope.policy = {}
    $scope.showCarModelInput = false
    $scope.carMakesOptions = carData.getMakes()
    $scope.carModelsOptions = {}

    $scope.onCarMakeChange = ->
      if $scope.policy.car_make
        $scope.showCarModelInput = true
        $scope.carModelsOptions = carData.getModels($scope.policy.car_make)
      else
        $scope.carModelsOptions = {}
        $scope.policy.car_model = ''
        $scope.showCarModelInput = false

    # TODO: validation
    $scope.register_policy = ->

      # TODO: add policy_type for more generality
      return unless window.web3
      web3.eth.sendTransaction
        to: CONTRACT_ADDRESS
        data:
          # TODO: ABI_4bytes_function_add_policy,
          car_model: $scope.car_model
          car_year: $scope.car_year
          initial_premium: $scope.initial_premium
          initial_deductible: $scope.initial_deductible
      , (error, address) ->
          # TODO
          return
]
