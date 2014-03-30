// AutoComplete  1.0
// Arguments: input string, url to send AJAX request, query string name eg. ?<query name>=<value> 
// and div id to show queried results
function AutoSearch(txt, url, qname, id)  {
  this.txt = txt;
  this.url = url;
  this.qname = qname;
  this.id = id;
}

AutoSearch.prototype.search = function()  {
  var url = this.url;
  var div = document.getElementById(this.id);

  // form encode query name and value
  var qname = encodeURIComponent(this.qname.replace(" ", "+"));
  var txt = encodeURIComponent(this.txt.replace(" ", "+"));

  var request = new XMLHttpRequest();
  request.open("GET", url + "?" + qname + "=" + txt);
  request.onreadystatechange = function()  {
    if(request.readyState === 4 && request.status === 200)  {
      div.innerHTML = request.responseText;
    }
  };
  request.send(null);
};