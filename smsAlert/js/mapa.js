// Variables y Objetos globales.
var v_mapa = null;

function cargarMapa(){
	var v_latitud =  -13.6501945;
	var v_longitud = -76.192383;
	var v_zoom = 10 ;
	
	// Datos de prueba.
	var v_testData = {
		max : 5,
		data : [ {
			lat : -13.5788,
			lng : -76.105777

		}, {
			lat : -13.57879,
			lng : -76.105777
		}, {
			lat : -13.577879,
			lng : -76.1059777
		}, {
			lat : -13.587879,
			lng : -76.1069777
		}, {
			lat : -13.579879,
			lng : -76.1079777
		}, {
			lat : -13.622472,
			lng : -76.180057
		}, {
			lat : -13.9205099,
			lng : -76.0049742
		}, {
			lat : -13.767073,
			lng : -76.141272
		} ]
	};

	var cfg = {
		
	  "radius": .01,
	  "maxOpacity": .8,  
	  "scaleRadius": true,
	  "useLocalExtrema": true,
	  latField: 'lat',
	  lngField: 'lng',
	  valueField: 'count'
	};
	
	// Humanitarian Style.
	var v_base_layer = L.tileLayer('http://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',{
		attribution: 'Data \u00a9 <a href="http://www.openstreetmap.org/copyright"> OpenStreetMap Contributors </a> Tiles \u00a9 HOT',
	    maxZoom: v_zoom
	});
	
	// Layer Mapa de calor.
	var v_heatmapLayer = new HeatmapOverlay(cfg);
	
	
	v_mapa = new L.Map('mapa', {
		center: new L.LatLng(v_latitud, v_longitud),
		zoom: v_zoom,
		layers: [
		    v_base_layer, 
		    v_heatmapLayer
		]
	});
	
	v_heatmapLayer.setData(v_testData);
} 