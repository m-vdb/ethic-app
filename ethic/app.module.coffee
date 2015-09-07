window.$ = window.jQuery = require('jquery')
window._ = require('lodash')
require 'bootstrap'
require 'angular'
require 'angular-route'

ethicApp = angular.module('ethicApp', [ 'ngRoute' ])
ethicApp.constant 'CONTRACT_ADDRESS', '0x0000'

# TODO: the address
ethicApp.config require('./app.routes.coffee')

# services
ethicApp.factory 'userData', require('./shared/userData.service.coffee')
ethicApp.factory 'networkData', require('./shared/networkData.service.coffee')

# controllers
ethicApp.controller 'dashboard', require('./components/dashboard/dashboard.controller.coffee')
ethicApp.controller 'menu', require('./components/menu/menu.controller.coffee')
