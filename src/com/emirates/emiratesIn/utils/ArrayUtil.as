package com.emirates.emiratesIn.utils
{
	/**
	 * @author Fraser Hobbs
	 */
	public class ArrayUtil
	{
		public static function shuffle(array:Array):void
		{
			for(var i:int = 0; i < array.length; i++)
			{
				var a:* = array[i];
				var b:* = Math.floor(Math.random() * array.length);
				array[i] = array[b];
				array[b] = a;
			}
		}
	}
}
