package org.voisen.crayon.support.applicationcontext
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.core.IInjector;
	import org.voisen.crayon.context.ApplicationContext;
	
	public class MockInjectorApplicationContext extends ApplicationContext
	{
		public function MockInjectorApplicationContext(injector:IInjector)
		{
			super(null, true);
			
			this.injector = injector;
		}
	}
}