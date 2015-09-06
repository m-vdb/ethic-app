window.$ = window.jQuery = require("jquery");
window._ = require("lodash");
require("bootstrap");
require("angular");
require("angular-route");

var ethicApp = angular.module('ethicApp', ['ngRoute']);

ethicApp.constant('CONTRACT_ADDRESS', '0x0000');  // TODO: the address
ethicApp.config(require('./app.routes.js'));

// services
ethicApp.factory('userData', require('./shared/userData.service.js'));
ethicApp.factory('networkData', require('./shared/networkData.service.js'));

// controllers
ethicApp.controller('dashboard', require('./components/dashboard/dashboard.controller.js'));
ethicApp.controller('menu', require('./components/menu/menu.controller.js'));
