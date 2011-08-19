package com.emirates.emiratesIn.display.ui.events
{
	import flash.events.Event;

	/**
	 * @author fraserhobbs
	 */
	public class GameEvent extends Event
	{
		public static const FAIL:String = "GameEvent_fail";
		public static const SUCCESS:String = "GameEvent_success";
		
		public function GameEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
