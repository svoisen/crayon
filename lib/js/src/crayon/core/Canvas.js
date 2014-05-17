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

(function( window )
{
  Canvas = function( canvas )
  {
    this.canvas = canvas;
  }

  var p = Canvas.prototype;

  p.canvas = null;

  p.clear = function()
  {
    var ctx = this.canvas.getContext('2d');
    ctx.clearRect( 0, 0, this.canvas.width, this.canvas.height );
  }

  p.draw = function( params )
  {
    params = ParamsUtil.setupParams( "shape", params )

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
        ctx.arc( params.center._collection[0] || 0, params.center._collection[1] || 0, params.radius || 0, 0, Math.PI*2, true );
        ctx.closePath();
        ctx.fill();
        break;

      case "rectangle":
        ctx.fillRect( params.corner._collection[0] || 0, params.corner._collection[1] || 0, params.width || 0, params.height || 0 );
        break;
    }
  }

  p.__defineGetter__('width', function(){ return this.canvas.width; });

  p.__defineGetter__('height', function(){ return this.canvas.height; });

  p.__defineGetter__('center', function(){ return this.canvas.width / 2; });

  p.__defineGetter__('middle', function(){ return this.canvas.height / 2; });

  p.__defineSetter__('background', function(value){ this.canvas.style.backgroundColor = value; });

  p.__defineGetter__('background', function(){ return this.canvas.style.backgroundColor; });

  window.Canvas = Canvas;

}( window ));

