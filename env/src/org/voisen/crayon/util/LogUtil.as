package org.voisen.crayon.util
{
	import flash.utils.getQualifiedClassName;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class LogUtil
	{	
		public static function getLogger( klass:Class ):ILogger
		{
			var className:String = getQualifiedClassName( klass ).replace( "::", "." );
			return Log.getLogger( className );
		}
	}
}