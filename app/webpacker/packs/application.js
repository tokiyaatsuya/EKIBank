// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
// Javascriptの読み込み
import '../src/javascript/base'
// CSSの読み込み
import '../src/stylesheets/application.scss'
// 画像の読み込み
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

var jQuery = require('jquery');
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

//require('../src/javascript/modules/questions_show_12.js');

Rails.start()
Turbolinks.start()
ActiveStorage.start()
