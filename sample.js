function numbersonly(myfield, e, dec)
{
  var key;
  var keychar;

  if (window.event)
    key = window.event.keyCode;
  else if (e)
    key = e.which;
  else
    return true;
  keychar = String.fromCharCode(key);

// control keys
  if ((key==null) || (key==0) || (key==8) || 
      (key==9) || (key==13) || (key==27) )
    return true;

// numbers
  else if ((("0123456789").indexOf(keychar) > -1))
    return true;

// decimal point jump
  else if (dec && (keychar == "."))
  {
    myfield.form.elements[dec].focus();
    return false;
  }
  else
    return false;
}

function verifyIP (IPvalue1,IPvalue2) {
  errorString = "";
  theName = "IPaddress";

  var ipPattern = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/;
  var ipArray1 = IPvalue1.match(ipPattern);
  var ipArray2 = IPvalue2.match(ipPattern);
  if (IPvalue1 == "0.0.0.0")
    errorString = errorString + theName + ': '+IPvalue1+' is a special IP address and cannot be used here.';
  else if (IPvalue1 == "255.255.255.255")
    errorString = errorString + theName + ': '+IPvalue1+' is a special IP address and cannot be used here.';
  if (ipArray1 == null)
    errorString = errorString + theName + ': '+IPvalue1+' is not a valid IP address.';
  else {
    for (i = 0; i < 4; i++) {
      thisSegment = ipArray1[i];
      if (thisSegment > 255) {
        errorString = errorString + theName + ': '+IPvalue1+' is not a valid IP address.';
        i = 4;
      }
      if ((i == 0) && (thisSegment > 255)) {
        errorString = errorString + theName + ': '+IPvalue1+' is a special IP address and cannot be used here.';
        i = 4;
      }
    }
  }
  extensionLength = 3;
  if (errorString != "") {
    alert (errorString);
    document.iprange.ip_oct_1f.focus();
    return false;
  }

  if (IPvalue2 == "0.0.0.0")
    errorString = errorString + theName + ': '+IPvalue2+' is a special IP address and cannot be used here.';
  else if (IPvalue2 == "255.255.255.255")
    errorString = errorString + theName + ': '+IPvalue2+' is a special IP address and cannot be used here.';
  if (ipArray2 == null)
    errorString = errorString + theName + ': '+IPvalue2+' is not a valid IP address.';
  else {
    for (i = 0; i < 4; i++) {
      thisSegment = ipArray2[i];
      if (thisSegment > 255) {
        errorString = errorString + theName + ': '+IPvalue2+' is not a valid IP address.';
        i = 4;
      }
      if ((i == 0) && (thisSegment > 255)) {
        errorString = errorString + theName + ': '+IPvalue2+' is a special IP address and cannot be used here.';
        i = 4;
      }
    }
  }
  extensionLength = 3;
  if (errorString != "") {
    alert (errorString);
    document.iprange.ip_oct_1t.focus();
    return false;
  }

  return true;
}

var alert_title='Input Restriction';

function limitTextarea(el,maxLines,maxChar){
if(!el.x){
el.x=uniqueInt();
el.onblur=function(){clearInterval(window['int'+el.x])}
}
window['int'+el.x]=setInterval(function(){
var lines=el.value.replace(/\r/g,'').split('\n'),
i=lines.length,
lines_removed,
char_removed;
if(maxLines&&i>maxLines){
alert('You can not enter\nmore than '+maxLines+' lines');
lines=lines.slice(0,maxLines);
lines_removed=1
}
if(maxChar){
i=lines.length;
while(i-->0)if(lines[i].length>maxChar){
lines[i]=lines[i].slice(0,maxChar);
char_removed=1
}
if(char_removed)alert('You can not enter more\nthan '+maxChar+' characters per line')
}
if(char_removed||lines_removed)el.value=lines.join('\n')
},50);
}

function uniqueInt(){
var num,maxNum=100000;
if(!uniqueInt.a||maxNum<=uniqueInt.a.length)uniqueInt.a=[];
do num=Math.ceil(Math.random()*maxNum);
while(uniqueInt.a.hasMember(num))
uniqueInt.a[uniqueInt.a.length]=num;
return num
}

Array.prototype.hasMember=function(testItem){
var i=this.length;
while(i-->0)if(testItem==this[i])return 1;
return 0
};

function set_ie_alert(){
window.alert=function(msg_str){
vb_alert(msg_str)
}
}
//-->
