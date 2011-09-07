package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import com.emirates.emiratesIn.model.ResultsModel;
	import com.emirates.emiratesIn.model.TestingModel;
	import com.emirates.emiratesIn.service.DatabaseService;

	import org.robotlegs.mvcs.SignalCommand;

	/**
	 * @author Fraser Hobbs
	 */
	public class TestCompleteCommand extends SignalCommand
	{
		[Inject]
		public var testingModel:TestingModel;
		
		[Inject]
		public var resultsModel:ResultsModel;
		
		[Inject]
		public var databaseService:DatabaseService;
		
		override public function execute() : void
		{
			testingModel.next();
			
			databaseService.insertTest(resultsModel.last.type, resultsModel.last.level, resultsModel.last.adjust, resultsModel.last.hold, resultsModel.last.position, resultsModel.last.feedback, resultsModel.last.quantative.target, resultsModel.last.quantative.startTime);
			
			Debug.log("TestCompleteCommand");
		}
	}
}
