/*
 * Copyright (c) 2010-2011 Sean Voisen.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package org.voisen.crayon
{
  import flash.display.Sprite;
  import flash.display.Graphics;

  import flash.events.Event;

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
          g.drawCircle( params.center.item_at(0) || 0, params.center.item_at(1) || 0, params.radius || 0 );
          break;

        case "ellipse":
          g.drawEllipse( params.center.item_at(0) || 0, params.center.item_at(1) || 0, params.width || 0, params.height || 0 );
          break;

        case "rectangle":
          g.drawRect( params.corner.item_at(0) || 0, params.corner.item_at(1) || 0, params.width || 0, params.height || 0 );
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
      return Math.round( Math.random()*(params.max - params.min) + params.min );
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

    protected function get pi():Number
    {
      return Math.PI;
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
