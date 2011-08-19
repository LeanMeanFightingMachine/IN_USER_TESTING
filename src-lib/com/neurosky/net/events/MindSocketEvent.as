package com.neurosky.net.events
{
	import flash.events.Event;

	/**
	 * @author justin
	 */
	public class MindSocketEvent extends Event
	{
		//	----------------------------------------------------------------
		//	CONSTANTS
		//	----------------------------------------------------------------
		public static const CONNECTION_OPEN : String = "MindSocketEvent_CONNECTION_OPEN";
		public static const CONNECTION_CLOSED : String = "MindSocketEvent_CONNECTION_CLOSED";
		public static const CONNECTION_ERROR : String = "MindSocketEvent_CONNECTION_ERROR";
		public static const PACKET_RECEIVED : String = "MindSocketEvent_PACKET_RECEIVED";
		
		//	----------------------------------------------------------------
		//	CONSTRUCTOR
		//	----------------------------------------------------------------
		public function MindSocketEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		//	----------------------------------------------------------------
		//	PUBLIC METHODS
		//	----------------------------------------------------------------
		override public function clone() : Event
		{
			return new MindSocketEvent(type,bubbles,cancelable);
		}

	}
}
