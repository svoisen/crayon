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
    this.canvas = new Canvas( canvas );
  }

  p.clear = function()
  {
    this.canvas.clear();
  }

  p.draw = function( params )
  {
    this.canvas.draw( params );
  }

  p.print = function( params )
  {
    params = ParamsUtil.setupParams( "output", params )
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
    params = ParamsUtil.setupParams( "max", params );
    return Math.round( Math.random()*(params.max - params.min) + params.min );
  }

  p.cos = function( params )
  {
    params = ParamsUtil.setupParams( "value", params );
    return Math.cos( params.value );
  }

  p.sin = function( params )
  {
    params = ParamsUtil.setupParams( "value", params );
    return Math.sin( params.value );
  }

  p.tick = function()
  {
    this.dispatchEvent( "frame", {} );
  }

  window.CrayonProgram = CrayonProgram;

}( window ));
