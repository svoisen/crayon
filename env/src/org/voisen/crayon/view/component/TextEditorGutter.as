package org.voisen.crayon.view.component
{
	import spark.components.TextArea;
	
	public class TextEditorGutter extends TextArea
	{
		public function TextEditorGutter()
		{
			super();
			
			editable = false;
			
			lineCount = 0;
		}
		
		public function set verticalScrollPosition( value:Number ):void
		{
			scroller.verticalScrollBar.value = value;
		}
		
		/**
		 * Always force editable to be false.
		 */
		override public function set editable( value:Boolean ):void
		{
			super.editable = false;
		}
		
		/**
		 * The number of lines to display.
		 */
		public function set lineCount( value:uint ):void
		{
			text = "";
			
			for( var i:uint = 0; i < value; i++ )
			{
				text += String(i+1) + "\n";
			}
		}
	}
}