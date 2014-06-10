// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.maskedinput
//= require jquery_ujs
//= require bootstrap/bootstrap
//= require_tree .
//= vendor/assets/javascripts/bootstrap/bootstrap.js

jQuery(function($){
  $("#usuario_cliente_attributes_celular").mask("(99)99999-9999");
  $("#usuario_cliente_attributes_telefone").mask("(99)9999-9999");
  $("#usuario_cliente_attributes_data_de_nascimento").mask("99/99/9999");
  $("#cliente_data_de_nascimento").mask("99/99/9999");
  $("#empresa_telefone").mask("(99)9999-9999");
});


