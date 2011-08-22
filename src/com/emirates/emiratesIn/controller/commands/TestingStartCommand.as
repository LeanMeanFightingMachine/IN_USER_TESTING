package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.model.TestModel;
	import org.robotlegs.mvcs.SignalCommand;

	/**
	 * @author Fraser Hobbs
	 */
	public class TestingStartCommand extends SignalCommand
	{
		[Inject]
		public var testmodel:TestModel;
		
		override public function execute():void
		{
			testmodel.reset();
		}
	}
}
