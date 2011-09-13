package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.model.AttentionModel;
	import com.emirates.emiratesIn.enum.State;
	import com.emirates.emiratesIn.model.TestingModel;
	import com.emirates.emiratesIn.service.DatabaseService;

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
		
		[Inject]
		public var attentionModel:AttentionModel;
		
		[Inject]
		public var databaseService:DatabaseService;
		
		override public function execute() : void
		{
			if (state == State.TESTING)
			{
				testingModel.reset();
				databaseService.insertUser();
			}
			else if (state == State.TRAINING)
			{
				attentionModel.reset();
			}
		}
	}
}
