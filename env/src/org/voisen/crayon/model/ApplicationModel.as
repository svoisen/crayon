package org.voisen.crayon.model
{
	import org.voisen.crayon.view.component.IEditor;

	public class ApplicationModel
	{
		protected var _currentEditor:IEditor;
		
		public function ApplicationModel()
		{
		}
			
		public function get currentEditor():IEditor
		{
			return _currentEditor;
		}
		
		public function set currentEditor(value:IEditor):void
		{
			_currentEditor = value;
		}
	}
}