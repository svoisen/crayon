(function( window )
{

  CrayonProgram = function( canvas )
  {
    this.initialize( canvas );

    Ticker.addListener( this );
  }

  var p = CrayonProgram.prototype; 

  p.canvas = null;
  p.pi = Math.PI;

  p._listeners = {};

  p.initialize = function( canvas )
  {
    this.canvas = canvas;
  }

  p.clear = function()
  {
    var ctx = this.canvas.getContext('2d');
    ctx.clearRect( 0, 0, this.canvas.width, this.canvas.height );
  }

  p.draw = function( params )
  {
    this._setupParams( "shape", params )

    var ctx = this.canvas.getContext('2d');

    if( !isNaN(params.color) )
    {
      var r = (params.color & 0xFF0000) >> 16;
      var g = (params.color & 0x00FF00) >> 8;
      var b = (params.color & 0x0000FF);
      params.color = "rgb(" + r + "," + g + "," + b + ")";
    }

    ctx.fillStyle = params.color;

    switch( params.shape )
    {
      case "circle":
        ctx.beginPath();
        ctx.arc( params.center.item_at(0) || 0, params.center.item_at(1) || 0, params.radius || 0, 0, Math.PI*2, true );
        ctx.closePath();
        ctx.fill();
        break;

      case "rectangle":
        ctx.fillRect( params.corner.item_at(0) || 0, params.corner.item_at(1) || 0, params.width || 0, params.height || 0 );
        break;
    }
  }

  p.print = function( params )
  {
    this._setupParams( "output", params )
    console.log( params.output );
  }

  p.addEventListener = function( eventName, listenerObj, listenerFunction )
  {
    this.removeEventListener( eventName, listenerObj, listenerFunction );
    if( this._listeners[eventName] == null )
      this._listeners[eventName] = [];

    this._listeners[eventName].push( {listenerObj:listenerObj, listenerFunction:listenerFunction} );
  }

  p.removeEventListener = function( eventName, listenerObj, listenerFunction )
  {
    if( this._listeners == null || this._listeners[eventName] == null )
      return;

    var list = this._listeners[eventName];
    for( var i = 0; i < list.length; i++ )
    {
      if( list[i].listenerObj == listenerObj && list[i].listenerFunction == listenerFunction )
      {
        this._listeners[eventName].splice( i, 1 );
      }
    }
  }

  p.dispatchEvent = function( eventName, eventObj )
  {
    if( this._listeners == null || this._listeners[eventName] == null ) 
      return;

    var list = this._listeners[eventName];
    for( var i = 0; i < list.length; i++ )
    {
      list[i].listenerObj[list[i].listenerFunction](eventObj);
    }
  }

  p.random = function( params )
  {
    this._setupParams( "max", params );
    return Math.round( Math.random()*(params.max - params.min) + params.min );
  }

  p.cos = function( params )
  {
    this._setupParams( "value", params );
    return Math.cos( params.value );
  }

  p.sin = function( params )
  {
    this._setupParams( "value", params );
    return Math.sin( params.value );
  }

  p.tick = function()
  {
    this.dispatchEvent( "frame", {} );
  }

  p._setupParams = function( defaultParamName, params )
  {
    if( params.__default )
    {
      params[defaultParamName] = params.__default;
    }

    return params;
  }
  
  window.CrayonProgram = CrayonProgram;

}( window ));
