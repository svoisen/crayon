package org.voisen.crayon
{
  import flash.display.Sprite;
  import flash.display.Stage;
  import flash.display.Graphics;
  import flash.display.StageScaleMode;
  import flash.display.StageAlign;

  import flash.events.Event;

  import flash.geom.Point;
  
  import org.voisen.crayon.color.Colors;

  public class CrayonProgram extends Sprite
  {
    protected var canvas:Object;

    public function CrayonProgram()
    {
      setupCanvas();
      stage.addEventListener( Event.RESIZE, handleStageResize );
    }

    protected function clear():void
    {
      graphics.clear();
    }

    protected function draw(params:Object):void
    {
      setupParams( "shape", params );

      var g:Graphics = graphics;
      g.beginFill( (params.color is String ? Colors.getColorValue( params.color ) : params.color) || 0x000000 );
      switch( params.shape )
      {
        case "circle":
          g.drawCircle( params.center[0] || 0, params.center[1] || 0, params.radius || 0 );
          break;

        case "ellipse":
          g.drawEllipse( params.center[0] || 0, params.center[1] || 0, params.width || 0, params.height || 0 );
          break;

        case "rectangle":
          g.drawRect( params.corner[0] || 0, params.corner[1] || 0, params.width || 0, params.height || 0 );
          break;

        case "line":
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
      setupParams( "max", params );
      return Math.random()*(params.max - params.min) + params.min;
    }

    protected function sin(params:Object):Number
    {
      setupParams( "value", params );
      return Math.sin( params.value );
    }

    protected function cos(params:Object):Number
    {
      setupParams( "value", params );
      return Math.cos( params.value );
    }

    private function setupParams( defaultParamName:String, params:Object ):Object
    {
      if( params.__default )
      {
        params[defaultParamName] = params.__default;
      }

      return params;
    }

    private function setupCanvas():void
    {
      canvas = {width:stage.stageWidth,height:stage.stageHeight};
    }

    private function handleStageResize( event:Event ):void
    {
      setupCanvas();
    }
  }
}
