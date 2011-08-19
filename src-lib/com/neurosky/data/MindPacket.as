package com.neurosky.data
{
	import com.adobe.serialization.json.JSONDecoder;
	import com.adobe.serialization.json.JSONParseError;
	/**
	 * @author Fraser Hobbs
	 */
	public class MindPacket
	{
		// ----------------------------------------------------------------
		// PUBLIC MEMBERS
		// ----------------------------------------------------------------
		public var signal : int = 200;
		public var attention : int;
		public var meditation : int;
		public var blink : int;
		
		// ----------------------------------------------------------------
		// CONSTRUCTOR
		// ----------------------------------------------------------------
		public function MindPacket(data:String):void
		{
			parse(data);
		}
		
		// ----------------------------------------------------------------
		// PRIVATE METHODS
		// ----------------------------------------------------------------
		private function parse(data:String):void
		{
			var packets : Array = data.split(/\r/);
			
			var obj : Object;
			for each (var packet:String in packets)
			{
				if (packet != "")
				{
					try
					{
						obj = new JSONDecoder(packet,false).getValue();
						
						if (obj["poorSignalLevel"] != null || obj["poorSignalLevel"] != undefined)
						{
							signal = obj["poorSignalLevel"];
							if (signal == 0)
							{
								attention = obj["eSense"]["attention"];
								meditation = obj["eSense"]["meditation"];
								
							}
						}
						else if(obj["blinkStrength"])
						{
							blink = obj["blinkStrength"];
						}
					}
					catch (error : JSONParseError)
					{
						// do error handling here
					}
				}
				
				data = null;
			}
		}
	}
}
