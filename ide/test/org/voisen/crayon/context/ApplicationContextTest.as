package org.voisen.crayon.context
{
	import flash.display.Sprite;
	
	import org.hamcrest.assertThat;
	import org.robotlegs.mvcs.SignalContext;
	import org.voisen.crayon.support.applicationcontext.MockInjectorApplicationContext;
	import org.voisen.crayon.support.applicationcontext.MockInstantiateStartupCommandInjector;

	public class ApplicationContextTest
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var context:ApplicationContext;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[After]
		public function tearDown():void
		{
			context = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function should_extend_signal_context():void
		{
			context = new ApplicationContext();
			
			assertThat(context is SignalContext);
		}
		
		[Test]
		public function should_execute_startup_command():void
		{
			var injector:MockInstantiateStartupCommandInjector = new MockInstantiateStartupCommandInjector();
			var context:MockInjectorApplicationContext = new MockInjectorApplicationContext(injector);
			
			context.startup();
			
			assertThat(injector.startupCommand.hasExecuted);
		}
	}
}