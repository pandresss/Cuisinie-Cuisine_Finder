// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree

$( () => {

});



//start of document ready

$(document).on('turbolinks:load' , function() {

  // slideshow stuff.
  // Hide the images
  $("#slideshow > div:gt(0)").hide();



  arr = []

  const appender = (sRes) => {
    // remove the previous search
    $('.restContainer').remove();
    // creating elements to append to the DOM
    $.each(sRes, (ind, val) => {
      // creating the elements we need
      const $container = $('<div class=\"restContainer\"></div>');
      const $name = $('<h1 class=\"resName\"></h1>').text(val.name);
      const $image = $('<img class=\"resImg\" src=\"' + val.img_url + '\">');
      const $addr = $('<p class=\"resAddr\"></p>').text(val.address);
      const $cost = $('<p class=\"resCost\"></p>').text("Avg cost for 2: $" + val.cost);
      const $rating = $('<p class=\"resRate\"></p>').text("Avg user rating: " + val.user_rating);
      const $id = $('<a href=\"/restaurants/' + val.restaurant_id + '\" />').val(val.restaurant_id);
      // appending them to the page
      $id.appendTo($container);
      $name.appendTo($id);
      $image.appendTo($id);
      $addr.appendTo($container);
      $cost.appendTo($container);
      $rating.appendTo($container);
      $('<br><br>').appendTo($container);
      $container.appendTo('.theRealPage');
      // console.log(container,name,image,addr,cost,rating);
      // console.log(val);

      arr.push({
        "lat": val.lat,
        "lon": val.lon
      }); // end of filling array with location of each searched restaurant

    }); // end of looping over the search results

    $.each(arr, (index, value) => {


    }); // making sure the array is there

  }; // end of appender function

  $(".click").click(() => {



    let click = $("#cuisine_id").val();

     // making sure we're sending the right cuisine type
//grabing information from the backend DB that pulled information from the external api via HTTParty
    $.ajax({
      method: 'POST',
      data: {
        cuisine: {
          "id": click
        }
      },
      url: '/apis',
      success: (data) => {
        // console.log(data)
        appender(data);
      },
      error: (jqx, error) => {
        console.log(error)
      }

    }); // end of ajax call



  }); // end of click function

  // slideshow
    // Hide the images
    $("#slideshow > div:gt(0)").hide();

    // method chaining for animation
    setInterval( () => {
      $('#slideshow > div:first')
        .fadeOut(2000)
        .next()
        .fadeIn(3000)
        .end()
        .appendTo('#slideshow');
    }, 8500);

  // google maps needs vanilla javascript
  function initMap() {



    var uluru = {
      lat: parseFloat(document.getElementById('lat').textContent),
      lng: parseFloat(document.getElementById('lon').textContent)
    };

    var map = new google.maps.Map(document.getElementById('this'), {
      zoom: 17,
      center: uluru
    });


    // console.log(uluru);

    let latitude = parseFloat(uluru.lat);
    let longitude = parseFloat(uluru.lng);

    // I mean, it's redundant to tell you what this is
    let restaurantLocation = {
      lat: latitude,
      lng: longitude
    };
    var marker = new google.maps.Marker({
      position: restaurantLocation,
      map: map
    });
    //floating markers on top of the google marker
    // var infoWindow = new google.maps.InfoWindow({
    //   map: map
    // });
//mouseover function would display if above code was working.
    marker.addListener('mouseover', function() {
      infoWindow.open(infoWindow.setContent($('#name').text()), marker);
    });

    marker.addListener('mouseout', function() {
      infoWindow.close(infoWindow.setContent("By"), marker);
    });

  } // end of initMap function

  initMap();

    $(".favorite").click(() => {



    let user_id = $(".user_id").text();
    let restaurant_id = $(".rest_id").text();

    $.ajax({
      method: 'GET',
      data: {
        restaurantsuser: {
          "user_id": user_id,
          "restaurant_id" :restaurant_id
        }
      },
      url: '/apis/new',
      success: (data) => {
      window.location.replace("/users/"+data.id)
      },
      error: (jqx, error) => {
        console.log(error)
      }

    }); // end of ajax call
  });
  // flash notifications need some style
    $('div.flash').delay(500).slideDown('normal', function() {
      $(this).delay(2500).slideUp();
    });

}); //end of document ready
