window.$ = require("jquery");
window._ = require("lodash");
require("angular");
require("angular-route");

var ethicApp = angular.module('ethicApp', ['ngRoute']);

ethicApp.config(require('./app.routes.js'));
// controllers
ethicApp.controller('dashboard', require('./components/dashboard/dashboard.controller.js'));
