package com.emirates.emiratesIn.net
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.emirates.emiratesIn.net.events.AttentionEvent;
	import com.neurosky.net.MindSocket;
	import com.neurosky.net.events.MindSocketEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author Fraser Hobbs
	 */
	public class Attention
	{
		// ----------------------------------------------------------------
		// PUBLIC STATIC MEMBERS
		// ----------------------------------------------------------------
		public static var connected : Boolean = false;
		public static var fake : Boolean = true;
		
		// ----------------------------------------------------------------
		// PRIVATE STATIC MEMBERS
		// ----------------------------------------------------------------
		private static var _eventDispatcher : EventDispatcher = new EventDispatcher();
		private static var _current : Number = 0;
		private static var _total : Number = 0;
		private static var _count : int = 0;
		private static var _history : Vector.<int> = new Vector.<int>();
		private static var _timer:Timer = new Timer(100);
		private static var _fakeAttention:int;

		// ----------------------------------------------------------------
		// PUBLIC STATIC METHODS
		// ----------------------------------------------------------------
		public static function start() : void
		{
			if (fake)
			{
				connected = true;
				dispatchEvent(new AttentionEvent(AttentionEvent.CONNECTED));
				
				startRandomising();
			}
			else
			{
				MindSocket.addEventListener(MindSocketEvent.PACKET_RECEIVED, onPacketReceived);
				MindSocket.connect();
				if (connected)
				{
					dispatchEvent(new AttentionEvent(AttentionEvent.CONNECTED));
				}
			}
		}

		// Encapsulate event dispatcher
		public static function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		public static function dispatchEvent(event : Event) : Boolean
		{
			return _eventDispatcher.dispatchEvent(event);
		}

		public static function hasEventListener(type : String) : Boolean
		{
			return _eventDispatcher.hasEventListener(type);
		}

		public static function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}

		// ----------------------------------------------------------------
		// ACCESSORS
		// ----------------------------------------------------------------
		public static function get current() : Number
		{
			return Attention._current;
		}
		
		public static function get average() : Number
		{
			return Attention._total / Attention._count;
		}

		public static function getSampleAverage(size:int) : Number
		{
			var total:Number = 0;
			var i:int = 0;
			while (i < Attention._history.length && i < size)
			{
				total += _history[i];
			}

			return total / i;
		}

		// ----------------------------------------------------------------
		// PRIVATE STATIC METHODS
		// ----------------------------------------------------------------
		private static function startRandomising():void
		{
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
			_timer.start();
		}

		private static function timerHandler(event : TimerEvent) : void
		{
			if(_timer.currentCount % 10 == 0)
			{
				_fakeAttention = int(Math.random() * 60) + 40;
				processData(_fakeAttention);
				trace(_fakeAttention);
			}
			
			dispatchEvent(new AttentionEvent(AttentionEvent.UPDATED, _fakeAttention));
		}
		
		private static function onPacketReceived(event : MindSocketEvent) : void
		{
			if (isNaN(MindSocket.currentPacket.attention) || MindSocket.currentPacket.attention == 0 && !MindSocket.currentPacket.blink)
			{
				if (connected)
				{
					connected = false;
					dispatchEvent(new AttentionEvent(AttentionEvent.DISCONNECTED));
				}
			}
			else if (!MindSocket.currentPacket.blink)
			{
				if (!connected)
				{
					connected = true;
					dispatchEvent(new AttentionEvent(AttentionEvent.CONNECTED));
				}
				
				processData(MindSocket.currentPacket.attention);

				dispatchEvent(new AttentionEvent(AttentionEvent.UPDATED, MindSocket.currentPacket.attention));
			}
		}

		private static function processData(data : int) : void
		{
			_current = data;

			_total += data;
			_count++;
			
			_history.push(data);
		}
	}
}
