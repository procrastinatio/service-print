# -*- coding: utf-8 -*-

<%
mode = request.params.get('mode')
lang = request.lang
appUrl = request.application_url.replace('http:', request.scheme + ':')
layersconfig = appUrl + '/rest/services/all/MapServer/layersConfig?lang=' + lang
import urllib2
f = urllib2.urlopen(layersconfig)
layersconfig = """if (typeof window['GeoAdmin'] == 'undefined') window['GeoAdmin'] =  {}; window.GeoAdmin.getConfig  = function(){ return %s } """ %f.read()
defaultLang = """function getDefaultLang() { return "%s" } """ % request.lang
%>

(function() {
var load = function() {
if (typeof window['GeoAdmin'] == 'undefined') window.GeoAdmin = {};
window.GeoAdmin.lang = "${lang}";
}
window.addEventListener ? 
window.addEventListener("load", load, false) :
window.attachEvent && window.attachEvent("onload", load);

${layersconfig|n}
// Load css
document.write('<link rel="stylesheet" type="text/css" href="' + "${h.versioned(request.static_url('chsdi:static/css/ga.css'))}" + '" />');
// Load js
document.write('<scr' + 'ipt type="text/javascript">' + ${defaultLang|n} + '</scr' + 'ipt>');
document.write('<scr' + 'ipt type="text/javascript" src="' + "${h.versioned(request.static_url('chsdi:static/js/serverconfig.js'))}" +  '"></scr' + 'ipt>');
document.write('<scr' + 'ipt type="text/javascript" src="' + "${h.versioned(request.static_url('chsdi:static/js/proj4js-compressed.js'))}" + '"></scr' + 'ipt>');
document.write('<scr' + 'ipt type="text/javascript" src="' + "${h.versioned(request.static_url('chsdi:static/js/EPSG21781.js'))}" + '"></scr' + 'ipt>');
document.write('<scr' + 'ipt type="text/javascript" src="' + "${h.versioned(request.static_url('chsdi:static/js/EPSG2056.js'))}" + '"></scr' + 'ipt>');
% if mode == 'debug':
document.write('<scr' + 'ipt type="text/javascript" src="' + "${h.versioned(request.static_url('chsdi:static/js/ga-whitespace.js'))}" + '"></scr' + 'ipt>');
% else:
document.write('<scr' + 'ipt type="text/javascript" src="' + "${h.versioned(request.static_url('chsdi:static/js/ga.js'))}" + '"></scr' + 'ipt>')
% endif
})();

