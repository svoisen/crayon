package org.voisen.crayon.event
{
	import flash.events.Event;
	
	public class CompilerEvent extends Event
	{
		public static const COMPILER_ERROR:String = "CompilerDelegateEvent.COMPILER_ERROR";
		public static const COMPILER_OUTPUT:String = "CompilerDelegateEvent.COMPILER_OUTPUT";
		
		public var output:String;
		
		public function CompilerEvent( type:String )
		{
			super(type, true, true);
		}
	}
}