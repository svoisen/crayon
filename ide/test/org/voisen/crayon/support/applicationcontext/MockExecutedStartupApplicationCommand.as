package org.voisen.crayon.support.applicationcontext
{
	import org.voisen.crayon.command.startup.StartupApplicationCommand;
	
	public class MockExecutedStartupApplicationCommand extends StartupApplicationCommand
	{
		public var hasExecuted:Boolean;
		
		public function MockExecutedStartupApplicationCommand()
		{
		}
		
		override public function execute():void
		{
			hasExecuted = true;
		}
	}
}