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
//= require jquery_ujs
//= require bootstrap
//= require_tree .

var jsonTags = [];
$.getJSON("http://localhost:3000/api/bookmarks.json", function (json) {
  $.each(json, function(key,val){
    $.each(val.tag_list, function(key, val){
      if ($.inArray(val,jsonTags) == -1){
        jsonTags.push(val);
      }
    })
    $('#bookmark_tag_list').select2({tags:jsonTags,
      tokenSeparators: [",", " "]}); 
  })
});

$('#bookmark_bucket').select2();
