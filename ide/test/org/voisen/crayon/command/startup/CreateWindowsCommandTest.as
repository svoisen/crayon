package org.voisen.crayon.command.startup
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.events.Event;
	
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.received;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.robotlegs.base.MediatorMap;
	import org.robotlegs.mvcs.SignalCommand;
	import org.voisen.crayon.view.editor.EditorWindow;

	public class CreateWindowsCommandTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var command:CreateWindowsCommand;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before(async)]
		public function setUp():void
		{
			command = new CreateWindowsCommand();
			
			Async.proceedOnEvent(this, prepare(MediatorMap), Event.COMPLETE);
		}
		
		[After]
		public function tearDown():void
		{
			closeAllWindows();
			
			command = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function closeAllWindows():void
		{
			for each (var window:NativeWindow in NativeApplication.nativeApplication.openedWindows)
				window.close();
		}
		
		protected function getWindowInstance(clazz:Class):NativeWindow
		{
			for each (var window:NativeWindow in NativeApplication.nativeApplication.openedWindows)
			{
				if (window is clazz)
					return window;
			}
			
			return null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function should_extend_signal_command():void
		{
			assertThat(command is SignalCommand);
		}
		
		[Test]
		public function should_create_editor_window():void
		{
			command.mediatorMap = nice(MediatorMap);
			
			command.execute();
			
			assertThat(NativeApplication.nativeApplication.activeWindow is EditorWindow);
		}
		
		[Test]
		public function should_create_mediator_for_editor_window_stage():void
		{
			command.mediatorMap = nice(MediatorMap);
			
			command.execute();
			
			var editorWindow:NativeWindow = getWindowInstance(EditorWindow);
			
			assertThat(command.mediatorMap, received().method('createMediator').arg(editorWindow.stage).once());
		}
	}
}