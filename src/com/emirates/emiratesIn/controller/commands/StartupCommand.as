package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.controller.signals.IntroductionStartSignal;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author Fraser Hobbs
	 */
	public class StartupCommand extends Command
	{
		[Inject]
		public var introductionStartSignal:IntroductionStartSignal;
		
		override public function execute() : void
		{
			introductionStartSignal.dispatch();
		}
	}
}
