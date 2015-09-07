module.exports = [
  '$scope', 'CONTRACT_ADDRESS',
  ($scope, CONTRACT_ADDRESS) ->
    $scope.formData = {}
    $scope.policy = {}
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
