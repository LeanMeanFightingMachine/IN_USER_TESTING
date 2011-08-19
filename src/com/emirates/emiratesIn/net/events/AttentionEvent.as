package com.emirates.emiratesIn.net.events
{
	import flash.events.Event;

	/**
	 * @author fraserhobbs
	 */
	public class AttentionEvent extends Event
	{
		//	----------------------------------------------------------------
		//	CONSTANTS
		//	----------------------------------------------------------------
		public static const CONNECTED : String = "AttentionMonitorEvent_CONNECTED";
		public static const DISCONNECTED : String = "AttentionMonitorEvent_DISCONNECTED";
		public static const UPDATED : String = "AttentionMonitorEvent_UPDATED";
		
		public var value:int;
		
		//	----------------------------------------------------------------
		//	CONSTRUCTOR
		//	----------------------------------------------------------------
		public function AttentionEvent(type : String, value:int = 0, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);

			this.value = value;
		}
		
		//	----------------------------------------------------------------
		//	PUBLIC METHODS
		//	----------------------------------------------------------------
		override public function clone() : Event
		{
			return new AttentionEvent(type,value,bubbles,cancelable);
		}
	}
}
