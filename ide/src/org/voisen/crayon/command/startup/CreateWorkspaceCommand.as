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

package org.voisen.crayon.command.startup
{
	import com.destroytoday.model.IApplicationModel;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Screen;
	
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.mvcs.SignalCommand;
	import org.voisen.crayon.view.editor.EditorWindow;
	
	public class CreateWorkspaceCommand extends SignalCommand
	{
		//--------------------------------------------------------------------------
		//
		//  Injections
		//
		//--------------------------------------------------------------------------
		
		[Inject]
		public var injector:IInjector;
		
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		[Inject]
		public var applicationModel:IApplicationModel;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function CreateWorkspaceCommand()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		override public function execute():void
		{
			var editorWindow:EditorWindow = new EditorWindow();
			
			injector.mapValue(DisplayObjectContainer, editorWindow.stage);
			mediatorMap.contextView = editorWindow.stage;
			mediatorMap.createMediator(editorWindow.view);
			
			editorWindow.title = applicationModel.name;
			//TODO - load saved window size
			
			editorWindow.center(Screen.mainScreen.visibleBounds);

			editorWindow.activate();
		}
	}
}