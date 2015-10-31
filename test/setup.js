window.$ = window.jQuery = require('jquery');
window._ = require('underscore');
window.Backbone = require('backbone');
require('marionette');
require('backbone-validation');
require('../ethic/utils/backbone.inheritance.coffee');


window.chai = require("chai");
window.expect = chai.expect;
var sinonChai = require("sinon-chai");
var chaiFuzzy = require("chai-fuzzy");
chai.use(sinonChai);
chai.use(chaiFuzzy);
