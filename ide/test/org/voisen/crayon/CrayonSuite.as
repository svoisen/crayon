package org.voisen.crayon
{
	import org.voisen.crayon.command.startup.CreateWindowsCommandTest;
	import org.voisen.crayon.view.editor.EditorWindowTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class CrayonSuite
	{
		//--------------------------------------------------------------------------
		//
		//  Commands
		//
		//--------------------------------------------------------------------------

		public var createWindowsCommandTest:CreateWindowsCommandTest;

		//--------------------------------------------------------------------------
		//
		//  Views
		//
		//--------------------------------------------------------------------------

		public var editorWindowTest:EditorWindowTest;
	}
}