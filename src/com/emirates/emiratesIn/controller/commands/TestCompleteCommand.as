package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import com.emirates.emiratesIn.model.TestingModel;
	import org.robotlegs.mvcs.SignalCommand;

	/**
	 * @author Fraser Hobbs
	 */
	public class TestCompleteCommand extends SignalCommand
	{
		[Inject]
		public var testingModel:TestingModel;
		
		override public function execute() : void
		{
			testingModel.next();
			
			Debug.log("TestCompleteCommand");
		}
	}
}
