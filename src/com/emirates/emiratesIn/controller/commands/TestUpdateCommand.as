package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.vo.ResultAttentionVO;
	import com.emirates.emiratesIn.model.ResultsModel;
	import com.emirates.emiratesIn.vo.UpdateVO;

	import org.robotlegs.mvcs.SignalCommand;

	/**
	 * @author Fraser Hobbs
	 */
	public class TestUpdateCommand extends SignalCommand
	{
		[Inject]
		public var vo:UpdateVO;
		
		[Inject]
		public var resultsModel:ResultsModel;
		
		override public function execute() : void
		{
			var result:ResultAttentionVO = new ResultAttentionVO();
			result.attention = vo.attention;
			result.hotspot = vo.hotspot;
			result.hit = vo.hit;
			result.time = vo.time;
			
			resultsModel.addAttention(result);
		}
	}
}
