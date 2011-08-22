package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.controller.signals.TrainingStartSignal;

	import org.robotlegs.mvcs.SignalCommand;

	/**
	 * @author Fraser Hobbs
	 */
	public class IntroductionCompleteCommand extends SignalCommand
	{
		[Inject]
		public var trainingStartSignal:TrainingStartSignal;
			
		override public function execute() : void
		{
			trainingStartSignal.dispatch();
		}
	}
}
