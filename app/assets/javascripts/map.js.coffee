# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# (c) 2014 Солопов Артемий Ильич / Artemiy Solopov

map = undefined
from_projection = new OpenLayers.Projection("EPSG:4326")
to_projection = new OpenLayers.Projection("EPSG:900913")

init = () ->
  mapnik = new OpenLayers.Layer.OSM()
  options =
    projection: from_projection
    displayProjection: to_projection
    center: new OpenLayers.LonLat(37.6187042, 55.7516335)
    controls: [new OpenLayers.Control.Navigation(), new OpenLayers.Control.PanZoomBar(), new OpenLayers.Control.ScaleLine()]
    eventListeners:
      'click': click_hdl
  position = new OpenLayers.LonLat(37.6187042, 55.7516335).transform( from_projection, to_projection)

  map = new OpenLayers.Map("map", options)
  map.addLayer mapnik
  map.setCenter position, 14

  #click_con = new OpenLayers.Control.Click()
  #console.log(click_con)
  #map.addControl(click_con)
  #click_con.activate()

click_hdl = (e) ->
  if $('#res').css('display') != 'none'
    $('#res').slideUp()
  lonlat = map.getLonLatFromPixel(e.xy)
  lonlat_t = lonlat.transform(to_projection, from_projection)
  console.log(lonlat_t)
  $.ajax('/map/search_within.json', {
    data:
      lat: lonlat_t.lat
      lon: lonlat_t.lon
    type: 'GET'
    success: (data) ->
      $('#res_tbl').empty()
      $('#res_tbl').append("
      <tr>
      <th>Название</th>
      <th>Адрес</th>
      <th>Широта</th>
      <th>Долгота</th>
      </tr>
      ")
      for rec in data
        console.log(rec)
        $('#res_tbl').append(
          "<tr><td>" + rec.name + "</td>
          <td>" + rec.address + "</td>
          <td>" + rec.latitude + "</td>
          <td>" + rec.longtitude + "</td></tr>"
        )
      $('#res').slideDown()
  })

$(document).ready () ->
  $('#res').css('display', 'none')
  if $('#map').length >= 0
    init()
