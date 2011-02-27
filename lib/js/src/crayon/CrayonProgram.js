(function( window )
{

  CrayonProgram = function( canvas )
  {
    this.initialize( canvas );
  }

  var p = CrayonProgram.prototype; 

  p.canvas = null;

  p.initialize = function( canvas )
  {
    this.canvas = canvas;
  }

  p.draw = function( params )
  {
    this._setupParams( "shape", params )

    var ctx = this.canvas.getContext('2d');

    ctx.fillStyle = params.color;

    switch( params.shape )
    {
      case "rectangle":
        ctx.fillRect( params.corner[0] || 0, params.corner[1] || 0, params.width || 0, params.height || 0 );
        break;
    }
  }

  p.print = function( params )
  {
    this._setupParams( "output", params )
    console.log( params.output );
  }

  p._setupParams = function( defaultParamName, params)
  {
    if( params.__default )
    {
      params[defaultParamName] = params.__default;
    }

    return params;
  }
  
  window.CrayonProgram = CrayonProgram;

}( window ));
