package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.vo.ResultVO;
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
			var last : ResultVO = resultsModel.last;
			databaseService.updateTest(last.quantative.target, last.quantative.startTime, last.quantative.completedTime);

			for (var i : int = 0; i < last.quantative.data.length; i++)
			{
				databaseService.insertData(last.quantative.data[i].attention, last.quantative.data[i].hotspot, last.quantative.data[i].hit, last.quantative.data[i].time);
			}
			
			testingModel.next();
		}
	}
}
