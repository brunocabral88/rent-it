google.maps.event.addDomListener(window, 'load', function () {
    console.log('loading map');
    var result = gon.result;
    var tools = [];
    for (var i = 0; i < result.length; i++){
        var tool = result[i];
        var latLng = new google.maps.LatLng(tool.lat, tool.lng);
        var toolObj = new storeLocator.Store(tool.id, latLng, null, {
            title: tool.name,
            address: tool.street_address
        })
        tools.push(toolObj);
    }

    console.log(tools);
    var map = new google.maps.Map(document.getElementById('map-canvas'), {
        center: new google.maps.LatLng(43.7181557,-79.5181424),
        zoom: 10,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        maxZoom: 13
    });
    console.log(map);

    var styles = [{"featureType":"administrative","elementType":"labels.text.fill","stylers":[{"color":"#444444"}]},{"featureType":"landscape","elementType":"all","stylers":[{"color":"#f2f2f2"}]},{"featureType":"poi","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"poi.business","elementType":"geometry.fill","stylers":[{"visibility":"on"}]},{"featureType":"road","elementType":"all","stylers":[{"saturation":-100},{"lightness":45}]},{"featureType":"road.highway","elementType":"all","stylers":[{"visibility":"simplified"}]},{"featureType":"road.arterial","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"water","elementType":"all","stylers":[{"color":"#b4d4e1"},{"visibility":"on"}]}];

    map.setOptions({styles: styles});

    var panelDiv = document.getElementById('panel');

    var dataFeed = new storeLocator.StaticDataFeed;

    dataFeed.setStores(tools);

    var view = new storeLocator.View(map, dataFeed, {
        geolocation: true
    });

    new storeLocator.Panel(panelDiv, {
        view: view
    });

});