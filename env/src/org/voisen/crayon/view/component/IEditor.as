package org.voisen.crayon.view.component
{
	public interface IEditor
	{
		function initializeBuffer( filePath:String, bufferText:String ):void;
		function get buffer():String;
		function get filePath():String;
		function get newBuffer():Boolean;
	}
}