package org.voisen.crayon
{
  import flash.display.Sprite;
  import flash.display.Graphics;
  import flash.events.Event;
  import flash.geom.Point;

  public class CrayonProgram extends Sprite
  {
    protected var canvas:Object;

    public function CrayonProgram()
    {
      canvas = {width:stage.stageWidth, height:stage.stageHeight};
    }

    protected function clear():void
    {
      graphics.clear();
    }

    protected function draw(params:Object):void
    {
      setupParams( "shape", params );

      var g:Graphics = graphics;
      g.beginFill( params.color || 0x000000 );
      switch( params.shape )
      {
        case "circle":
          if( !params.center )
          {
            params.center = [0, 0];
          }

          g.drawCircle( params.center[0], params.center[1], params.radius || 0 );
          break;

        case "rectangle":
          g.drawRect( params.corner[0] || 0, params.corner[1] || 0, params.width || 0, params.height || 0 );
          break;

        default:
          throw new Error( params.shape + " is not a valid shape" );
          break;
      }

      g.endFill();
    }

    protected function print(params:Object):void
    {
      setupParams( "output", params );

      trace( params.output );
    }

    protected function random(params:Object):Number
    {
      return Math.random()*(params.max - params.min) + params.min;
    }

    private function setupParams( defaultParamName:String, params:Object ):Object
    {
      if( params.__default )
      {
        params[defaultParamName] = params.__default;
      }

      return params;
    }
  }
}
