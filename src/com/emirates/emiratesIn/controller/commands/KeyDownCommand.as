package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.controller.signals.ShowHideOutputSignal;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author Fraser Hobbs
	 */
	public class KeyDownCommand extends Command
	{
		[Inject]
		public var event:KeyboardEvent;
		
		[Inject]
		public var showOutputSignal:ShowHideOutputSignal;
		
		override public function execute():void
		{
			if(event.keyCode == Keyboard.O)
			{
				showOutputSignal.dispatch();
			}
		}
	}
}
