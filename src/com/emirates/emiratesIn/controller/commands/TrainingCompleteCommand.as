package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.controller.signals.TestingStartSignal;

	import org.robotlegs.mvcs.SignalCommand;

	/**
	 * @author Fraser Hobbs
	 */
	public class TrainingCompleteCommand extends SignalCommand
	{
		[Inject]
		public var testingStartSignal:TestingStartSignal;
		
		override public function execute():void
		{
			testingStartSignal.dispatch();
		}
	}
}
