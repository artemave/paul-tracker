// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require fastclick
//= require pace
//= require moment
//= require nouislider
//= require foundation
//= require turbolinks
//= require turboboost
//= require_tree .

$(function(){
    $(document).foundation();

    $(document).on('page:fetch', function() {
        $('#loading_overlay').fadeIn()
    })
    $(document).on('ready page:change', function() {
        setTimeout(function() {
            $('#loading_overlay').fadeOut()
        }, 100)
    })

    FastClick.attach(document.body);
});
