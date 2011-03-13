package org.voisen.crayon
{
	import org.voisen.crayon.command.startup.CreateWorkspaceCommandTest;
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
		
		public var createWindowsCommandTest:CreateWorkspaceCommandTest;
		
		//--------------------------------------------------------------------------
		//
		//  Views
		//
		//--------------------------------------------------------------------------
		
		public var editorWindowTest:EditorWindowTest;
	}
}