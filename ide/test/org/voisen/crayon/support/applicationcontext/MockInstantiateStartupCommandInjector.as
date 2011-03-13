package org.voisen.crayon.support.applicationcontext
{
	import org.swiftsuspenders.Injector;
	import org.voisen.crayon.command.startup.StartupApplicationCommand;
	
	public class MockInstantiateStartupCommandInjector extends Injector
	{
		public var hasInstantiatedStartupCommand:Boolean;
		
		public var startupCommand:MockExecutedStartupApplicationCommand;
		
		public function MockInstantiateStartupCommandInjector()
		{
		}
		
		override public function instantiate(clazz:Class):*
		{
			if (clazz == StartupApplicationCommand)
				hasInstantiatedStartupCommand = true;
			
			return (startupCommand = new MockExecutedStartupApplicationCommand);
		}
	}
}