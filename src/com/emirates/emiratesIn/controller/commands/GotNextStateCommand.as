package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.enum.State;
	import com.emirates.emiratesIn.model.TestingModel;

	import org.robotlegs.mvcs.SignalCommand;

	/**
	 * @author Fraser Hobbs
	 */
	public class GotNextStateCommand extends SignalCommand
	{
		[Inject]
		public var state:String;
		
		[Inject]
		public var testingModel:TestingModel;
		
		override public function execute() : void
		{
			if (state == State.TESTING)
			{
				testingModel.reset();
			}
		}
	}
}
