/*
Copyright (c) 2011 Jonnie Hallman

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

package org.voisen.crayon.view.editor.toolbar
{
	import com.destroytoday.component.button.ButtonState;
	import com.destroytoday.component.button.IButtonState;
	import com.destroytoday.graphics.IDecoratable;
	import com.destroytoday.graphics.IDecorator;
	
	import flash.display.Graphics;
	
	public class ToolbarButtonDecorator implements IDecorator
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _target:IDecoratable;
		
		protected var _state:IButtonState;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ToolbarButtonDecorator(target:ToolbarButton)
		{
			this.target = target;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get target():IDecoratable
		{
			return _target;
		}
		
		public function set target(value:IDecoratable):void
		{
			_target = value;
		}
		
		public function get state():IButtonState
		{
			return _state;
		}
		
		public function set state(value:IButtonState):void
		{
			_state = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function drawUpState():void
		{
			var graphics:Graphics = _target.graphics;
			
			graphics.clear();
			graphics.beginFill(0x009900);
			graphics.drawRect(0.0, 0.0, _target.width, _target.height);
			graphics.endFill();
		}
		
		protected function drawOverState():void
		{
			var graphics:Graphics = _target.graphics;
			
			graphics.clear();
			graphics.beginFill(0x00CC00);
			graphics.drawRect(0.0, 0.0, _target.width, _target.height);
			graphics.endFill();
		}
		
		protected function drawDownState():void
		{
			var graphics:Graphics = _target.graphics;
			
			graphics.clear();
			graphics.beginFill(0x00FF00);
			graphics.drawRect(0.0, 0.0, _target.width, _target.height);
			graphics.endFill();
		}
		
		protected function drawDisabledState():void
		{
			var graphics:Graphics = _target.graphics;
			
			graphics.clear();
			graphics.beginFill(0x666666);
			graphics.drawRect(0.0, 0.0, _target.width, _target.height);
			graphics.endFill();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function draw():void
		{
			switch (_state)
			{
				case ButtonState.UP:
					drawUpState();
					break;
				case ButtonState.OVER:
					drawOverState();
					break;
				case ButtonState.DOWN:
					drawDownState();
					break;
				case ButtonState.DISABLED:
					drawDisabledState();
					break;
			}
		}
	}
}