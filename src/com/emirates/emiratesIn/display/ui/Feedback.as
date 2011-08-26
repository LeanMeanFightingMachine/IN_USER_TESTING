package com.emirates.emiratesIn.display.ui
{

	/**
	 * @author fraserhobbs
	 */
	public class Feedback extends Clip
	{
		private static const MAX:int = 50;
		
		private var _attention:Array = [];
		private var _target:int;
		
		public function Feedback()
		{
			super();
		}
		
		public function reset():void
		{
			hide();
			
			_attention = [];
			graphics.clear();
		}
		
		public function target(value:int):void
		{
			_target = value;
		}
		
		public function attention(value:int):void
		{
			_attention.push(value);
			
			if (_attention.length > MAX)
			{
				_attention.shift();
			}
			
			update();
		}
		
		override protected function resize() : void
		{
			super.resize();
			
			update();
		}
		
		override protected function draw() : void
		{
			super.draw();
			
			var _width:int = stage.stageWidth;
			var _height:int = stage.stageHeight;
			
			var inc:int = Math.ceil(_width / (MAX - 1));
			var start:int = _width - ((_attention.length - 1) * inc);
			var i : int ;
			
			graphics.clear();
			
			graphics.lineStyle(10,0x999999,0.5);
			graphics.moveTo(0, _height - int((_target / 100) * _height));
			graphics.lineTo(_width, _height - int((_target / 100) * _height));
			
			graphics.lineStyle(10,0x999999, 0.5);
			graphics.moveTo(start, _height - int((_attention[0] / 100) * _height));
			for (i = 1; i < _attention.length; i++)
			{
				graphics.lineTo(start + (i * inc), _height - int((_attention[i] / 100) * _height));
			}
			
		}
	}
}
