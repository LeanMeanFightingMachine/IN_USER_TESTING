package com.neurosky.net
{
	import com.adobe.serialization.json.JSONEncoder;
	import com.neurosky.data.MindPacket;
	import com.neurosky.net.events.MindSocketEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;

	/**
	 * @author justin
	 */
	public class MindSocket
	{
		// ----------------------------------------------------------------
		// CONSTANTS
		// ----------------------------------------------------------------
		private static const HOST : String = "127.0.0.1";
		private static const PORT : int = 13854;
		
		// ----------------------------------------------------------------
		// PRIVATE MEMBERS
		// ----------------------------------------------------------------
		private static var _eventDispatcher : EventDispatcher = new EventDispatcher();
		private static var _socket : Socket;
		private static var _packet : MindPacket;

		// ----------------------------------------------------------------
		// PUBLIC METHODS
		// ----------------------------------------------------------------
		public static function connect() : void
		{
			//_packet = new JSONPacketData();
			_socket = new Socket(HOST, PORT);

			var configuration : Object = new Object();
			configuration["enableRawOutput"] = false;
			configuration["format"] = "Json";
			_socket.writeUTFBytes(new JSONEncoder(configuration).getString());

			_socket.addEventListener(Event.CLOSE, onClose);
			_socket.addEventListener(Event.CONNECT, onConnect);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
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
		// EVENT HANDLERS
		// ----------------------------------------------------------------
		private static function onSocketData(event : ProgressEvent) : void
		{
			_packet = new MindPacket(_socket.readUTFBytes(_socket.bytesAvailable));
			_socket.flush();
			
			dispatchEvent(new MindSocketEvent(MindSocketEvent.PACKET_RECEIVED));
		}
		
		private static function onSecurityError(event : SecurityErrorEvent) : void
		{
			trace("onSecurityError: " + event);
			dispatchEvent(new MindSocketEvent(MindSocketEvent.CONNECTION_ERROR));
		}

		private static function onIOError(event : IOErrorEvent) : void
		{
			trace("onIOError: " + event);
			dispatchEvent(new MindSocketEvent(MindSocketEvent.CONNECTION_ERROR));
		}

		private static function onConnect(event : Event) : void
		{
			trace("onConnect: " + event);
			dispatchEvent(new MindSocketEvent(MindSocketEvent.CONNECTION_OPEN));
		}

		private static function onClose(event : Event) : void
		{
			trace("onClose: " + event);
			dispatchEvent(new MindSocketEvent(MindSocketEvent.CONNECTION_CLOSED));
		}

		// ----------------------------------------------------------------
		// PUBLIC ACCESSORS
		// ----------------------------------------------------------------
		public static function get currentPacket() : MindPacket
		{
			return _packet;
		}
	}
}
