package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.vo.TestVO;
	import com.emirates.emiratesIn.model.TestModel;
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
		
		override public function execute() : void
		{
			testModel.setup(vo);
		}
	}
}
