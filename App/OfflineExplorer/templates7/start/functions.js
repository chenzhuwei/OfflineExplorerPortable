var tips = 0;
var currTip = 0;
var request;
var currFolder = null;

function doLoad(url, callback) {
	if (window.XMLHttpRequest) {
		request = new XMLHttpRequest();
		request.onreadystatechange = callback;
		request. open("POST", url, true);
		request. send(null);
	} else if (window. ActiveXObject) {
		request = new ActiveXObject("Microsoft.XMLHTTP");
		if (request) {
			request.onreadystatechange = callback;
			request. open("POST", url, true);
			request. send();
		}
	}
}

function nextTip(x)
{
	if (!x) // forward
	{
		currTip++;
		if (currTip == tips) currTip = 0;
	} else { //back
		currTip--;
		if (currTip < 0) currTip = tips - 1;
	}
	doLoad('tip.htm?tip='+currTip, changeTip)
}

function changeTip()
{
	if (request.readyState == 4) {
		if(request.status == 200) {
			var el = document.getElementById('tip');
			if (el) el.innerHTML = request.responseText;
		}
	}
}

function setStartPage(el)
{
	var url = 'setstart.htm?start=' + (el.checked ? "1" : "0");
	doLoad(url, null);
}

function expandProjects(id)
{
	var el = document.getElementById("p-"+id);
	if (el) {
		var r = new XMLHttpRequest();
		r.onreadystatechange = function(){
			if (r.readyState == 4) {
				if (r.status == 200) {
					el.innerHTML = r.responseText;
					var a = document.getElementById("a-"+id);
					if (a) a.className = 'expander expanded';
				}
			}
		};
		var url = "nodes.htm?parent="+id;
		r.open("POST", url, true);
		r.send(null);
	}
}

function loadProjects(id)
{
	if (id == 0) 
	{
		expandProjects(id);
		return;
	}
	
	var el = document.getElementById("p-"+id);
	if (el) {
		var a = document.getElementById("a-"+id);
		if (a.className == 'expander expanded')
		{
			el.innerHTML = '';
			a.className = 'expander closed';
		} 
		else 
		{
			var r = new XMLHttpRequest();
			r.onreadystatechange = function(){
				if (r.readyState == 4) {
					if (r.status == 200) {
						el.innerHTML = r.responseText;
						a.className = 'expander expanded';
					}
				}
			};
			var url = "nodes.htm?parent="+id;
			r.open("POST", url, true);
			r.send(null);
		}
	}
}

function checkBox(name)
{
	var e = document.getElementById(name);
	if (e) e.checked = !e.checked;
}
function checkRadio(name)
{
	var e = document.getElementById(name);
	if (e) e.checked = true;
}


function enableControl(name, enable)
{
	var e = document.getElementById(name);
	if (e) e.disabled = enable ? "" : "disabled";
}

function parseServer(url)
{
	var e = url.split("\/");
	return e.length > 2 ? e[0] + "//" + e[2] : "http://" + e[0];
}

function parsePath(url)
{
	var e = url.split("\#");
	var e = e[0].split("\?");
	var e = e[0].split("\/");
	if (e.length > 2)
	{
		var s = "";
		for (var i = 0; i < e.length - 1; i++) s += e[i] + "/";
		s += e[e.length - 1];
		return s;
	}
	return "http://" + e[0];
}

function copyProjectName()
{
	var url = document.getElementById("prj-url");
	var name = document.getElementById("prj-name");
	if (name.value.length == 0) name.value = url.value;
}

function checkControls()
{
	var url = document.getElementById("prj-url");
	enableControl("prj-submit", url.value != "http://" && url.value.length > 0);
	
	var levels = document.getElementById("prj-levels");
	enableControl("prj-level", levels.checked);

	var location_url_note = document.getElementById("prj-location-url-note");
	location_url_note.innerHTML = parsePath(url.value);
	var e = document.getElementById("prj-location-url-hidden");
	if (e) e.value=location_url_note.innerHTML;
	
	var location_server_note = document.getElementById("prj-location-server-note");
	location_server_note.innerHTML = parseServer(url.value);
	var e = document.getElementById("prj-location-server-hidden");
	if (e) e.value=location_server_note.innerHTML;
	
	var e = document.getElementById("prj-location-any");
	enableControl("prj-images-any-location", !e.checked);
	
	var e = document.getElementById("prj-download-skip");
	enableControl("prj-graphics", e.checked);
	enableControl("prj-video", e.checked);
	enableControl("prj-audio", e.checked);
	enableControl("prj-archive", e.checked);
}

function expandFolder(id, projects)
{
	var el = document.getElementById("f-"+id);
	if (el) {
		var r = new XMLHttpRequest();
		r.onreadystatechange = function(){
			if (r.readyState == 4) {
				if (r.status == 200) {
					el.innerHTML = r.responseText;
				}
			}
		};
		var url = "folder.htm?parent="+id;
		if (projects) url += "&p=1";
		r.open("POST", url, true);
		r.send(null);
	}
}

function loadFolders(id, projects)
{
	if (id == 0) 
	{
		expandFolder(id, projects);
		return;
	}
	
	var el = document.getElementById("f-"+id);
	if (el) {
		var a = document.getElementById("a-"+id);
		if (currFolder != null) currFolder.className = "";
		
		var r = new XMLHttpRequest();
		r.onreadystatechange = function(){
			if (r.readyState == 4) {
				if (r.status == 200) {
					el.innerHTML = r.responseText;
					currFolder = a;
					currFolder.className = 'selected';
					enableControl('prj-next', currFolder != null);
					var e = document.getElementById('prj-folder');
					if (e) e.value = id;
				}
			}
		};
		var url = "folder.htm?parent="+id;
		if (projects) url += "&p=1";
		r.open("POST", url, true);
		r.send(null);
	}
}

function nextStep()
{
	var p1 = document.getElementById("page1");
	var p2 = document.getElementById("page2");
	p1.style.display = "none";
	p2.style.display = "";
	var url = document.getElementById("prj-url");
	if (url) url.focus();
}
function prevStep()
{
	var p1 = document.getElementById("page1");
	var p2 = document.getElementById("page2");
	p1.style.display = "";
	p2.style.display = "none";
}
