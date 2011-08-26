package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.model.ResultsModel;
	import com.emirates.emiratesIn.model.TestModel;
	import com.emirates.emiratesIn.vo.TestVO;

	import org.robotlegs.mvcs.SignalCommand;

	/**
	 * @author Fraser Hobbs
	 */
	public class GotNextTestCommand extends SignalCommand
	{
		[Inject]
		public var vo:TestVO;
		
		[Inject]
		public var testModel:TestModel;
		
		[Inject]
		public var resultsModel:ResultsModel;
		
		override public function execute() : void
		{
			testModel.setup(vo);
			
			resultsModel.add();

			resultsModel.type = vo.type;
			resultsModel.level = vo.level;
			resultsModel.adjust = vo.adjust;
			resultsModel.hold = vo.hold;
			resultsModel.feedback = vo.feedback;
		}
	}
}
