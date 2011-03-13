package org.voisen.crayon.command.shutdown
{
	import com.destroytoday.window.WindowManager;
	
	import flash.events.Event;
	
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.received;
	
	import org.flexunit.async.Async;
	import org.hamcrest.assertThat;
	import org.robotlegs.mvcs.SignalCommand;

	public class CloseAllWindowsCommandTest
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var command:CloseAllWindowsCommand;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before(async)]
		public function setUp():void
		{
			command = new CloseAllWindowsCommand();
			
			Async.proceedOnEvent(this, prepare(WindowManager), Event.COMPLETE);
		}
		
		[After]
		public function tearDown():void
		{
			command = null;
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
		public function should_close_all_windows_on_window_manager():void
		{
			command.windowManager = nice(WindowManager);
			
			command.execute();
			
			assertThat(command.windowManager, received().method('closeAllWindows').once());
		}
	}
}