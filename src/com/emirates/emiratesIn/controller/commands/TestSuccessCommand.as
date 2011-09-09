package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import com.emirates.emiratesIn.model.ResultsModel;
	import com.emirates.emiratesIn.service.DatabaseService;
	import com.emirates.emiratesIn.vo.ResultVO;

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
		
		[Inject]
		public var databaseService:DatabaseService;
		
		override public function execute() : void
		{
			resultsModel.completedTime = completedTime;
			
			//Debug.log(">>> completedTime : " + completedTime);
			
			//var last : ResultVO = resultsModel.last;
			
			//Debug.log(">>> last.quantative.completedTime : " + last.quantative.completedTime);
			
			//databaseService.updateTest(last.quantative.target, last.quantative.startTime, last.quantative.completedTime);
		}

	}
}
