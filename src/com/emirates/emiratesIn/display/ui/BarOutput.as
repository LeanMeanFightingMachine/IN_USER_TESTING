package com.emirates.emiratesIn.display.ui
{
	import flash.display.Shape;
	import flash.display.Sprite;

	/**
	 * @author fraserhobbs
	 */
	public class BarOutput extends Sprite
	{
		private var _canvas:Shape = new Shape();
		
		public function BarOutput()
		{
			addChild(_canvas);
		}
		
		public function update(data:Object):void
		{
			_canvas.graphics.clear();
			
			
		}
	}
}
