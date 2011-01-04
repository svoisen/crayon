package org.voisen.crayon.business
{
	import mx.logging.ILoggingTarget;
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	import mx.logging.targets.TraceTarget;

	public class LogDelegate
	{
		public function setupLogging():void
		{
			var traceTarget:TraceTarget = new TraceTarget();
			traceTarget.filters = ["org.voisen.crayon.*"];
			traceTarget.level = LogEventLevel.DEBUG;
			traceTarget.includeLevel = true;
			traceTarget.includeCategory = true;
			Log.addTarget( traceTarget as ILoggingTarget );
		}
	}
}