package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.enum.Config;
	import com.emirates.emiratesIn.model.AttentionModel;
	import com.emirates.emiratesIn.model.TestModel;
	import com.emirates.emiratesIn.vo.AttentionVO;
	import com.emirates.emiratesIn.vo.ResultVO;

	import org.robotlegs.mvcs.SignalCommand;

	/**
	 * @author Fraser Hobbs
	 */
	public class TestStartCommand extends SignalCommand
	{
		[Inject]
		public var attentionModel:AttentionModel;
		
		[Inject]
		public var testModel:TestModel;
		
		override public function execute() : void
		{
			var attention : AttentionVO = new AttentionVO();
			attention.raw = attentionModel.getRaw();
			attention.overallAverage = attentionModel.getOverallAverage();
			attention.sampleAverage = attentionModel.getSampleAverage(Config.TESTING_SAMPLE_SIZE);
			
			testModel.start(attention);
		}
	}
}
