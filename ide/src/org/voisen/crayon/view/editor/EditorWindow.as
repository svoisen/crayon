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

package org.voisen.crayon.view.editor
{
	import com.destroytoday.window.Window;
	
	import flash.display.NativeWindowInitOptions;
	import flash.events.Event;

	public class EditorWindow extends Window
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		public var view:EditorView;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function EditorWindow()
		{
			super(new NativeWindowInitOptions());
			
			createChildren();
			addListeners();
			setupSize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function createChildren():void
		{
			view = stage.addChild(new EditorView()) as EditorView;
		}
		
		protected function addListeners():void
		{
			stage.addEventListener(Event.RESIZE, stage_resizeHandler);
		}
		
		protected function setupSize():void
		{
			stage.stageWidth = 600.0;
			stage.stageHeight = 600.0;
		}
		
		protected function updateViewSize():void
		{
			view.width = stage.stageWidth;
			view.height = stage.stageHeight;
			
			view.validate();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Handlers
		//
		//--------------------------------------------------------------------------
		
		protected function stage_resizeHandler(event:Event):void
		{
			updateViewSize();
		}
	}
}