package com.emirates.emiratesIn.view.components.events
{
	import flash.events.Event;

	/**
	 * @author Fraser Hobbs
	 */
	public class TestingEvent extends Event
	{
		public static const NEXT:String = "TestingEvent_next";
		public static const RETRY:String = "TestingEvent_retry";
		public static const START:String = "TestingEvent_start";
		
		public function TestingEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
