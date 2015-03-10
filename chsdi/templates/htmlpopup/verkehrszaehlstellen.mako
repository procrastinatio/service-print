# -*- coding: utf-8 -*-

<%inherit file="base.mako"/>
<%def name="table_body(c, lang)">
<%
    zaehlstelle = c['layerBodId'] + '.' + 'zaehlstellen_bezeichnung'
    nummer = c['layerBodId'] + '.' + 'id'
%>
<% c['stable_id'] = True %>
  <table class="table-with-border kernkraftwerke-extended">
    <tr><td class="cell-left">${_(nummer)}</td>                 <td>${c['featureId']}</td></tr>
    <tr><td class="cell-left">${_(zaehlstelle)}</td>            <td>${c['attributes']['zaehlstellen_bezeichnung']}</td></tr>
    <tr><td class="cell-left">${_('physischvirtuell')}</td>     <td>${c['attributes']['zst_physisch_virtuell'] or '-'}</td></tr>
    <tr><td class="cell-left">${_('messstellentyp')}</td>       <td>${c['attributes']['messstellentyp'] or '-'}</td></tr>
</%def>

<%def name="extended_info(c, lang)">
<style type="text/css">
.htmlpopup-footer{
display:none !important;
}
</style>
<title>Verkehrszaehlstellen</title> 
<body onload="init()">
<div class="zsborder">
<table border="0px" cellpadding="0px" cellspacing="2px" width="100%">
    <tr>
        <td width="25%">&nbsp;</td>
        <td width="20%">&nbsp;</td>
        <td width="25%">&nbsp;</td>
        <td width="30%" >&nbsp;</td>
    </tr>
    <tr>
        <th class="cell-left">Zahlstelle Nr. (AVZ)</th>
        <td>${c['featureId'] or '-'}</td>
        <th class="cell-left">Bezeichnung</th>
        <td>${c['attributes']['zaehlstellen_bezeichnung'] or '-'}</td>
    </tr>
    <tr>
        <th class="cell-left">SSVZ Nr.</th>
        <td>${c['attributes']['uno_zaehlstelle'] or '-'}</td>
        <th class="cell-left">Richtung 1</th>
        <td>${c['attributes']['richtung_1'] or '-'}</td>
    </tr>
    <tr>
        <th>Kanton</th>
        <td>${c['attributes']['kanton'] or '-'}</td>
        <th>Richtung 2</th>
        <td>${c['attributes']['richtung_2'] or '-'}</td>
    </tr>
    <tr>
        <th>Swiss 10</th>
        <td>${c['attributes']['swiss_10'] or '-'}</td>
        <th>Netz</th>
        <td>${c['attributes']['netz'] or '-'}</td>
    </tr>
    <tr>
        <th>Status</th>
        <td>${c['attributes']['status'] or '-'}</td>
        <th>Strasse</th>
        <td>${c['attributes']['strasse'] or '-'}</td>
    </tr>
    <tr>
        <th>Anwendung</th>
        <td>${c['attributes']['messstellentyp'] or '-'}</td>
        <th>Koordinate OST</th>
        <td>${c['attributes']['koordinate_ost'] or '-'}</td>
    </tr>
    <tr>
        <th>Art</th>
        <td>${c['attributes']['zst_physisch_virtuell'] or '-'}</td>
        <th>Koordinate NORD</th>
        <td>${c['attributes']['koordinate_nord'] or '-'}</td>
    </tr>
    <tr>
        <th>Anzahl Fahrstreifen</th>
        <td>${c['attributes']['anzahl_fahrstreifen_tot'] or '-'}</td>
        <th>Inbetriebnahme</th>
        <td>${c['attributes']['inbetriebnahme'] or '-'}</td
    ></tr>
</table>
</div>
<p>Um zus&auml;tzliche Informationen &uuml;ber Z&auml;hlstellen zu erhalten, kontaktieren Sie bitte <a href="mailto:verkehrsdaten@astra.admin.ch">verkehrsdaten@astra.admin.ch</a></p>
</div>
<br />

<div class="chsdi-map-container table-with-border">
 <div id="map"></div>
</div>
  <br />
<div class="chsdi-map-container table-with-border"> 
 <div id="map2"></div>
</div>
</div>
  <br />
  <script type="text/javascript">
    function showhide (id) {
       var e = document.getElementById(id);
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
    }
    function init() {
      // Create a GeoAdmin Map
      var map = new ga.Map({
      // Define the div where the map is placed
          target: 'map',
          view: new ol.View({
          // Define the default resolution
          // 10 means that one pixel is 10m width and height
          // List of resolution of the WMTS layers:
          // 650, 500, 250, 100, 50, 20, 10, 5, 2.5, 2, 1, 0.5, 0.25, 0.1
          resolution: 10,
          // Define a coordinate CH1903 (EPSG:21781) for the center of the view
          center: [${c['attributes']['koordinate_ost']},${c['attributes']['koordinate_nord']}]
          }),
          tooltip: false, 
          interactions: ol.interaction.defaults({doubleClickZoom: false, dragPan: false, mouseWheelZoom: false})
      });
      
      var lyr = ga.layer.create('ch.swisstopo.pixelkarte-farbe');
      var lyr2 = ga.layer.create('ch.astra.strassenverkehrszaehlung_messstellen-uebergeordnet');
      var lyr3 = ga.layer.create('ch.astra.strassenverkehrszaehlung_messstellen-regional_lokal');

      map.addLayer(lyr); map.addLayer(lyr2); map.addLayer(lyr3);

    //second Map
      var map2 = new ga.Map({
      // Define the div where the map is placed
         target: 'map2',
         // Create a 2D view
         view: new ol.View({
         // Define the default resolution
         // 10 means that one pixel is 10m width and height
         // List of resolution of the WMTS layers:
         // 650, 500, 250, 100, 50, 20, 10, 5, 2.5, 2, 1, 0.5, 0.25, 0.1
         resolution: 2,
         // Define a coordinate CH1903 for the center of the view
         center: [${c['attributes']['koordinate_ost']},${c['attributes']['koordinate_nord']}]
         }),
         tooltip: false,
         interactions: ol.interaction.defaults({doubleClickZoom: false, dragPan: false, mouseWheelZoom: false})
      });

      map2.addLayer(lyr); map2.addLayer(lyr2); map2.addLayer(lyr3);
    }
  </script>
  <script type="text/javascript" src="//api3.geo.admin.ch/loader.js"></script>
</body>
</%def>

