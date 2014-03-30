// pid:  picture id
// tid:  feedback square id
// sel:  select form for picking person
// submit:  confirm button to submit form
// xloc, yloc, width, height:  hidden form elements to be filled with x, y, width and height of tag box 
function Tagger(pid, tid, sel, submit, xloc, yloc, mywidth, myheight)  {
  this.pid = pid;
  this.tid = tid;
  this.sel = sel;
  this.submit = submit;
  this.xloc = xloc;
  this.yloc = yloc;
  this.mywidth = mywidth;
  this.myheight = myheight;
}

// respond to mouse drag event, move tag box and fill in hidden form elements
Tagger.prototype.drag = function()  {
  this.sel.style.display = "inline";
  this.submit.style.display = "inline";
  var tagBox = document.getElementById(this.tid);
  var divBox = document.getElementById(this.pid);
  var img = divBox.getElementsByTagName("img")[0];
  var imgWidth = img.clientWidth;
  var imgHeight = img.clientHeight;
  var xloc = this.xloc;
  var yloc = this.yloc;
  var mywidth = this.mywidth;
  var myheight = this.myheight;
  // record original mouse down location
  var origX, origY;
  // register mouse down handler for tag box
  divBox.onmousedown = function(e)  {
    origX = e.clientX - divBox.offsetLeft + document.documentElement.scrollLeft;
    origY = e.clientY - divBox.offsetTop + document.documentElement.scrollTop;
    tagBox.style.left = origX + "px";
    tagBox.style.top = origY + "px";
    tagBox.style.width = "0px";
    tagBox.style.height = "0px";
    tagBox.style.display = "block";
    divBox.addEventListener("mousemove", moveHandler, true);
    divBox.addEventListener("mouseup", upHandler, true);
    e.stopPropagation();
    e.preventDefault();
  };
  function moveHandler(e)  {
    // if drag out of boundary, restrict it to image boundary
    var mouseX = e.clientX - divBox.offsetLeft + document.documentElement.scrollLeft;
    var mouseY = e.clientY - divBox.offsetTop + document.documentElement.scrollTop;
    var dragWidth =  mouseX - origX;
    var dragHeight =  mouseY - origY;
    var remWidth = (dragWidth > 0) ? imgWidth - origX : origX;
    var remHeight = (dragHeight > 0) ? imgHeight - origY : origY;

    var absWidth = Math.abs(dragWidth);
    var absHeight = Math.abs(dragHeight);

    var isOOB = false;
    var boxWidth, boxHeight;
    if(absWidth > remWidth - 5)  {
      boxWidth = remWidth;
      isOOB = true;
    }
    else if(absHeight > remHeight - 5) {
      boxHeight = remHeight;
      isOOB = true;
    }
    else  {
      boxWidth = absWidth;
      boxHeight = absHeight;
    }
    if(dragWidth < 0)  {
      tagBox.style.left = mouseX + "px";
    }
    if(dragHeight < 0)  {
      tagBox.style.top = mouseY + "px";
    }
    tagBox.style.width = boxWidth + "px";
    tagBox.style.height = boxHeight + "px";
    if(isOOB)  {
      upHandler(e);
    }
    e.stopPropagation();
    e.preventDefault();
  }
  function upHandler(e)  {
    divBox.removeEventListener("mousemove", moveHandler, true);
    divBox.removeEventListener("mouseup", upHandler, true);
    e.stopPropagation();
    e.preventDefault();
    xloc.value = tagBox.offsetLeft;
    yloc.value = tagBox.offsetTop;
    mywidth.value = tagBox.clientWidth;
    myheight.value = tagBox.clientHeight;
  }
};