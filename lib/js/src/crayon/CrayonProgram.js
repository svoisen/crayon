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
    setupParams( "shape", params )

    this.canvas.fillStyle = params.color;

    switch( params.shape )
    {
      case "rectangle":
        this.canvas.fillRect( params.corner[0] || 0, params.corner[1] || 0, params.width || 0, params.height || 0 );
        break;
    }
  }

  p.print = function( params )
  {
    setupParams( "output", params )
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
