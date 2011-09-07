package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.service.DatabaseService;
	import com.emirates.emiratesIn.model.StateModel;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Fraser Hobbs
	 */
	public class StartupCommand extends Command
	{
		[Inject]
		public var stateModel:StateModel;
		
		[Inject]
		public var databaseService:DatabaseService;
		
		override public function execute() : void
		{
			databaseService.openDatabaseConnection();
			
			stateModel.next();
		}
	}
}
