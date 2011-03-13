package org.voisen.crayon.command.startup
{
	import com.destroytoday.model.ApplicationModel;
	
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObjectContainer;
	import flash.display.NativeWindow;
	import flash.display.Screen;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.received;
	import mockolate.stub;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import org.robotlegs.base.MediatorMap;
	import org.robotlegs.mvcs.SignalCommand;
	import org.voisen.crayon.view.editor.EditorWindow;

	public class CreateWorkspaceCommandTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var command:CreateWorkspaceCommand;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before(async, order=0)]
		public function setUp():void
		{
			command = new CreateWorkspaceCommand();
			
			Async.proceedOnEvent(this, prepare(SwiftSuspendersInjector, MediatorMap, ApplicationModel), Event.COMPLETE);
		}
		
		[Before(order=1)]
		public function populateActors():void
		{
			command.injector = nice(SwiftSuspendersInjector);
			command.mediatorMap = nice(MediatorMap);
			command.applicationModel = nice(ApplicationModel);
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
			command.execute();
			
			assertThat(NativeApplication.nativeApplication.activeWindow is EditorWindow);
		}
		
		[Test]
		public function should_set_mediator_map_context_view_to_editor_window_stage():void
		{
			command.execute();
			
			var editorWindow:EditorWindow = getWindowInstance(EditorWindow) as EditorWindow;
			
			assertThat(command.mediatorMap, received().setter('contextView').arg(editorWindow.stage));
		}
		
		[Test]
		public function should_map_display_object_container_to_editor_window_stage():void
		{
			command.execute();
			
			var editorWindow:EditorWindow = getWindowInstance(EditorWindow) as EditorWindow;
			
			assertThat(command.injector, received().method('mapValue').args(DisplayObjectContainer, editorWindow.stage));
		}
		
		[Test]
		public function should_create_mediator_for_editor_view():void
		{
			command.execute();
			
			var editorWindow:EditorWindow = getWindowInstance(EditorWindow) as EditorWindow;
			
			assertThat(command.mediatorMap, received().method('createMediator').arg(editorWindow.view).once());
		}
		
		[Test]
		public function should_set_editor_window_title_to_application_name():void
		{
			const applicationName:String = 'Crayon';
			
			stub(command.applicationModel).getter('name').returns(applicationName);
			
			command.execute();
			
			var editorWindow:EditorWindow = getWindowInstance(EditorWindow) as EditorWindow;
			
			assertThat(editorWindow.title, equalTo(applicationName));
		}
		
		[Test]
		public function should_center_editor_window_on_main_screen():void
		{
			command.execute();
			
			var editorWindow:EditorWindow = getWindowInstance(EditorWindow) as EditorWindow;
			var screenRect:Rectangle = Screen.mainScreen.visibleBounds;
			var expectedX:int = screenRect.x + (screenRect.width - editorWindow.width) * 0.5;
			var expectedY:int = screenRect.y + (screenRect.height - editorWindow.height) * 0.5;
			
			assertThat(editorWindow.x, equalTo(expectedX));
			assertThat(editorWindow.y, equalTo(expectedY));
		}
		
		[Test]
		public function should_activate_editor_window():void
		{
			command.execute();
			
			var editorWindow:EditorWindow = getWindowInstance(EditorWindow) as EditorWindow;
			
			assertThat(editorWindow.active);
		}
	}
}