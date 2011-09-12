package com.emirates.emiratesIn.display.ui
{
	import flash.display.Sprite;

	/**
	 * @author Fraser Hobbs
	 */
	public class OutputKey extends Sprite
	{
		private var _items:Array = new Array();
		
		public function OutputKey()
		{
		}
		
		public function clear():void
		{
			while(_items.length > 0)
			{
				removeChild(_items.pop());
			}
		}
		
		public function add(colour:Number, text:String):void
		{
			_items.push(addChild(new OutputKeyItem(colour, text, _items.length * 15)));
		}
	}
}
