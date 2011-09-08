package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.model.TestingModel;

	import org.robotlegs.mvcs.SignalCommand;

	/**
	 * @author Fraser Hobbs
	 */
	public class TestInitialCommand extends SignalCommand
	{
		[Inject]
		public var testingModel:TestingModel;
		
		override public function execute() : void
		{
			testingModel.next();
		}
	}
}
