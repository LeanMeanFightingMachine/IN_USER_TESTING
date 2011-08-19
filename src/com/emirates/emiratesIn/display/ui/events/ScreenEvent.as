package com.emirates.emiratesIn.display.ui.events
{
	import flash.events.Event;

	/**
	 * @author Fraser Hobbs
	 */
	public class ScreenEvent extends Event
	{
		public static const NEXT:String = "ScreenEvent_next";
		public static const PREVIOUS:String = "ScreenEvent_previous";
		
		public function ScreenEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
