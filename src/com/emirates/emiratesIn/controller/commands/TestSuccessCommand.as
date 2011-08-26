package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.model.ResultsModel;

	import org.robotlegs.mvcs.SignalCommand;

	/**
	 * @author Fraser Hobbs
	 */
	public class TestSuccessCommand extends SignalCommand
	{
		[Inject]
		public var completedTime:int;
		
		[Inject]
		public var resultsModel:ResultsModel;
		
		override public function execute() : void
		{
			resultsModel.completedTime = completedTime;
		}

	}
}
