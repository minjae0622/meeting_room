String.prototype.isEmail             = function(){return this.match(/^[_a-zA-Z0-9-\.]+@[\._a-zA-Z0-9-]+\.[a-zA-Z]+$/);}
String.prototype.isEmpty             = function(){return this.trim().length == 0;}
String.prototype.isNumber            = function(){return this.match(/^\d+$/);}
String.prototype.trim                = function(){return this.replace(/(^\s*)|(\s*$)|($\s*)/g, "");}
String.prototype.toSpcLetter         = function(){return this.trim().replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\"","&quot;");}
String.prototype.isvalidDateFormat   = function(){return this.match(/[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])/);}
String.prototype.isValidHourFormat   = function(){return this.match(/[01]\d|2[0-3]/);}
String.prototype.isValidMinuteFormat = function(){return this.match(/([0-5]\d)/);}      
String.prototype.replaceAll          = function(from, to) {return this.replace(new RegExp(from, "g"), to); }

String.prototype.ByteLength = function() {
    var i,ch;
    var strLength = this.length;
    var count = 0;

    for(i=0;i<strLength;i++)
    {
        ch = escape(this.charAt(i));

        if(ch.length > 4)
            count += 2;
        else if(ch!='\r') 
            count++;
    }
    return count;
}

function fnGetCookie2010( name ){
	var nameOfCookie = name + "=";
	var x = 0;
	while ( x <= document.cookie.length ){
		var y = (x+nameOfCookie.length);
		if ( document.cookie.substring( x, y ) == nameOfCookie ) {
			if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
				endOfCookie = document.cookie.length;
			return unescape( document.cookie.substring( y, endOfCookie ) );
		}
		x = document.cookie.indexOf( " ", x ) + 1;
		if ( x == 0 )
		break;
	}
   return "";
}

function fnSetCookie2010( name, value, expiredays ){
	if (typeof(expiredays) == "undefined" || expiredays == null) {
		expiredays = "";
	}
	if (expiredays == ""){
		document.cookie = name + "=" + escape( value ) + "; path=/;"
	}else{
		var todayDate = new Date();
		todayDate.toGMTString();
		todayDate.setDate( todayDate.getDate() + expiredays );
		document.cookie = name + "=" + escape( value ) + "; path=/;expires="+ todayDate.toGMTString() + ";"
	}
}