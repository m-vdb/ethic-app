window.$ = window.jQuery = require("jquery");
window._ = require("lodash");
require("bootstrap");
require("angular");
require("angular-route");

var ethicApp = angular.module('ethicApp', ['ngRoute']);

ethicApp.config(require('./app.routes.js'));
// controllers
ethicApp.controller('dashboard', require('./components/dashboard/dashboard.controller.js'));
ethicApp.controller('menu', require('./components/menu/menu.controller.js'));


/* TODO

-> use http://chancejs.com/ to generate random information
-> use different services that retrieves data from API
-> have a switch in those services to retrieve data from web3
-> menu bar
*/
