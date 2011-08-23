package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.model.StateModel;

	import org.robotlegs.mvcs.SignalCommand;

	/**
	 * @author Fraser Hobbs
	 */
	public class StateCompleteCommand extends SignalCommand
	{
		[Inject]
		public var stateModel:StateModel;
		
		override public function execute() : void
		{
			stateModel.next();
		}
	}
}
