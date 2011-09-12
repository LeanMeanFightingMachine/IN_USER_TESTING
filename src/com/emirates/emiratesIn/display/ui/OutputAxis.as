package com.emirates.emiratesIn.display.ui
{
	import flash.display.Sprite;
	/**
	 * @author Fraser Hobbs
	 */
	public class OutputAxis extends Sprite
	{
		private var _labelX:OutputLabel;
		private var _labelY:OutputLabel;
		
		public function OutputAxis(w:int, h:int, ix:Number, iy:Number, mx:Number, my:Number, lx:String, ly:String):void
		{
			super();
			
			var sx : Number = w / mx;
			var sy : Number = h / my;
			
			graphics.lineStyle(1,0x000000);
			graphics.moveTo(0, 0);
			graphics.lineTo(0, h);
			graphics.lineTo(w, h);
			
			var p:int;
			
			p = 0;
			while(p <= mx)
			{
				graphics.moveTo(p * sx, h);
				graphics.lineTo(p * sx, h + 5);
				
				addChild(new AxisLabel(p.toString(), p * sx, h+5));
				
				p += ix;
			}
			
			p = 0;
			while(p <= my)
			{
				graphics.moveTo(0, p * sy);
				graphics.lineTo(-5, p * sy);
				
				addChild(new AxisLabel(p.toString(), -5, h - (p * sy), true));
				
				p += iy;
			}
			
			_labelX = new OutputLabel(lx);
			addChild(_labelX);
			_labelX.x = int(w * 0.5);
			_labelX.y = h + 30;
			
			_labelY = new OutputLabel(ly);
			addChild(_labelY);
			_labelY.x = -60;
			_labelY.y = int(h * 0.5);
			_labelY.rotation = -90;
			
		}
	}
}
