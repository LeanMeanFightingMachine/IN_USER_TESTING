package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.enum.Config;
	import com.emirates.emiratesIn.vo.AttentionVO;
	import com.emirates.emiratesIn.model.TestModel;
	import com.emirates.emiratesIn.model.AttentionModel;
	import com.emirates.emiratesIn.net.events.AttentionEvent;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author fraserhobbs
	 */
	public class AttentionUpdateCommand extends Command
	{
		[Inject]
		public var event:AttentionEvent;
		
		[Inject]
		public var attentionModel:AttentionModel;
		
		[Inject]
		public var testModel:TestModel;
		
		override public function execute():void
		{
			attentionModel.add(event.value);
			
			var attention : AttentionVO = new AttentionVO();
			attention.raw = attentionModel.getRaw();
			attention.overallAverage = attentionModel.getOverallAverage();
			attention.sampleAverage = attentionModel.getSampleAverage(Config.TESTING_SAMPLE_SIZE);
			
			testModel.update(attention);
		}
	}
}
