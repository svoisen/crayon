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

package org.voisen.crayon.core
{
  import flash.display.Graphics;
  import flash.display.Sprite;
  import flash.display.Stage;

  import org.voisen.crayon.color.Colors;
  import org.voisen.crayon.util.ParamsUtil;

	public class Canvas
	{
    protected var stage:Stage;
    protected var backgroundCanvas:Sprite;
    protected var foregroundCanvas:Sprite;
    protected var backgroundColor:uint;
    protected var explicitWidth:Number;
    protected var explicitHeight:Number;

		public function Canvas( stage:Stage )
		{
      this.stage = stage;

      backgroundCanvas = stage.addChild( new Sprite() ) as Sprite;
      foregroundCanvas = stage.addChild( new Sprite() ) as Sprite;

      explicitWidth = explicitHeight = 0;
      backgroundColor = 0xFFFFFF;
		}

    public function clear():void
    {
      foregroundCanvas.graphics.clear();
    }

    public function draw( params:Object ):void
    {
      params = ParamsUtil.setupParams( "shape", params );

      var center:List;
      var corner:List;

      var g:Graphics = foregroundCanvas.graphics;
      g.beginFill( (params.color is String ? Colors.getColorValue( params.color ) : params.color) || 0x000000 );

      switch( params.shape )
      {
        case "circle":
          center = params.center as List;
          g.drawCircle( center._collection[0] || 0, center._collection[1] || 0, params.radius || 0 );
          break;

        case "ellipse":
          center = params.center as List;
          g.drawEllipse( center._collection[0] || 0, center._collection[1] || 0, params.width || 0, params.height || 0 );
          break;

        case "rectangle":
          corner = params.corner as List;
          g.drawRect( corner._collection[0] || 0, corner._collection[1] || 0, params.width || 0, params.height || 0 );
          break;

        case "line":
          break;

        default:
          throw new Error( params.shape + " is not a valid shape" );
          break;
      }

      g.endFill();
    }

    public function set width( value:Number ):void
    {
      explicitWidth = value;

      updateBackground();
    }

    public function get width():Number
    {
      return explicitWidth;
    }

    public function set height( value:Number ):void
    {
      explicitHeight = value;

      updateBackground();
    }

    public function get height():Number
    {
      return explicitHeight;
    }

    public function get center():Number
    {
      return width / 2;
    }

    public function get middle():Number
    {
      return height / 2;
    }

    public function set background( value:uint ):void
    {
      backgroundColor = value;

      updateBackground();
    }

    public function get background():uint
    {
      return backgroundColor;
    }

    protected function updateBackground():void
    {
      var g:Graphics = backgroundCanvas.graphics;
      g.beginFill( backgroundColor, 1 );
      g.drawRect( 0, 0, width, height );
      g.endFill();
    }
	}
}