package org.voisen.crayon
{
  import flash.display.Sprite;
  import flash.display.Graphics;
  import flash.events.Event;
  import flash.geom.Point;

  public class CrayonProgram extends Sprite
  {
    private var curX:Number;
    private var curY:Number;

    public function CrayonProgram()
    {
      setup();
      addEventListener( Event.ENTER_FRAME, function(event:Event):void{loop();} );
    }

    protected function setup():void
    {
    }

    protected function loop():void
    {
    }

    protected function move(params:Object):void
    {
      var g:Graphics = graphics;
      
      if( params.__default )
      {
        if( !typeof(params.__default) == Point )
          throw new Error( "Invalid default parameter" );

        curX = params.__default.x;
        curY = params.__default.y;
      }
      else
      {
        if( !typeof(params.point) == Point )
          throw new Error( "point is not a Point" );

        curX = params.point.x;
        curY = params.point.y;
      }

      g.moveTo(curX, curY);
    }

    protected function draw(params:Object):void
    {
      var g:Graphics = graphics;
      g.beginFill( params.color || 0x000000 );
      switch( params.shape )
      {
        case "circle":
          g.drawCircle( curX, curY, params.radius || 0 );
          break;

        case "rectangle":
          g.drawRect( curX, curY, params.width || 0, params.height || 0 );
          break;

        default:
          throw new Error( "Invalid shape specified" );
          break;
      }
      g.endFill();
    }
  }
}
