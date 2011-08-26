package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.vo.HotspotVO;
	import com.emirates.emiratesIn.model.ResultsModel;
	import org.robotlegs.mvcs.SignalCommand;

	/**
	 * @author Fraser Hobbs
	 */
	public class TestHotspotCommand extends SignalCommand
	{
		[Inject]
		public var vo:HotspotVO;
		
		[Inject]
		public var resultsModel:ResultsModel;
		
		override public function execute() : void
		{
			resultsModel.target = vo.target;
			resultsModel.startTime = vo.time;
		}
	}
}