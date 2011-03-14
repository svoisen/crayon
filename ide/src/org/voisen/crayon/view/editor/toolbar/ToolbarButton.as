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
	import com.destroytoday.component.button.ButtonAdapter;
	import com.destroytoday.component.button.IButtonAdapter;
	import com.destroytoday.display.MeasuredSprite;
	import com.destroytoday.graphics.IDecoratable;
	import com.destroytoday.invalidation.InvalidationFlag;
	
	public class ToolbarButton extends MeasuredSprite implements IDecoratable
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _buttonAdapter:ButtonAdapter;
		
		protected var decorator:ToolbarButtonDecorator;
		
		//--------------------------------------------------------------------------
		//
		//  Flags
		//
		//--------------------------------------------------------------------------
		
		protected var stateFlag:InvalidationFlag;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ToolbarButton()
		{
			createProperties();
			mapFlags();
			addListeners();
			layoutView();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get buttonAdapter():IButtonAdapter
		{
			return _buttonAdapter;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function createProperties():void
		{
			_buttonAdapter = new ButtonAdapter(this);
			decorator = new ToolbarButtonDecorator(this);
			stateFlag = new InvalidationFlag('state');
		}
		
		protected function mapFlags():void
		{
			flagManager.mapMethod(updateView, sizeFlag, stateFlag);
		}
		
		protected function addListeners():void
		{
			_buttonAdapter.stateChanged.add(buttonAdapter_stateChangedHandler);
		}
		
		protected function layoutView():void
		{
			width = 40.0;
			height = 40.0;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Invalidation
		//
		//--------------------------------------------------------------------------
		
		protected function updateView():void
		{
			decorator.state = _buttonAdapter.state;
			
			decorator.draw();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Handlers
		//
		//--------------------------------------------------------------------------
		
		protected function buttonAdapter_stateChangedHandler(buttonAdapter:IButtonAdapter):void
		{
			flagManager.invalidate(stateFlag);
		}
	}
}