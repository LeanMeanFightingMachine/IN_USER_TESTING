package com.emirates.emiratesIn.display.ui.events
{
	import flash.events.Event;

	/**
	 * @author fraserhobbs
	 */
	public class PopupEvent extends Event
	{
		public static const COMPLETE:String = "PopupEvent_complete";
		
		public function PopupEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
