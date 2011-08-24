package com.emirates.emiratesIn.display.ui
{
	import com.greensock.TweenMax;

	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;

	/**
	 * @author Fraser Hobbs
	 */
	public class Vignette extends Clip
	{
		private static const FADE_DISTANCE:int = 50;
		
		public var scale:Number = 1;
		
		private var _growing : Boolean = false;
		private var _inner : Number = 255 - FADE_DISTANCE;
		private var _outer:Number = 255;
		
		public function Vignette()
		{
			super();
		}
		
		public function reset():void
		{
			scale = 1;
			scaleUpdate();
			
			_growing = false;
			
			hide();
		}
		
		public function animateIn(duration:Number):void
		{
			if (!_growing)
			{
				_growing = true;
					
				TweenMax.killTweensOf(this);
				TweenMax.to(this, duration, {scale:0, onUpdate:scaleUpdate});
			}
		}
		
		public function animateOut():void
		{
			if (_growing)
			{
				_growing = false;
				
				TweenMax.killTweensOf(this);
				TweenMax.to(this, 1, {scale:1, onUpdate:scaleUpdate});
			}
		}
		
		public function stop():void
		{
			TweenMax.killTweensOf(this);
		}
			
		override protected function resize() : void
		{
			super.resize();
			
			update();
		}
			
		override protected function draw() : void
		{
			super.draw();
			
			var w:int = stage.stageWidth;
			var h:int = stage.stageHeight;
			
			var colours:Array = [0x000000,0x000000];
			var alphas : Array = [0, 1];
			var ratios : Array = [_inner, _outer];
			var matrix : Matrix = new Matrix();
			matrix.createGradientBox(w, h);
			
			graphics.clear();
			graphics.lineStyle();
			graphics.beginGradientFill(GradientType.RADIAL, colours, alphas, ratios, matrix, SpreadMethod.PAD);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
		}
		
		private function scaleUpdate():void
		{
			_outer = 255 * scale;
			_inner = _outer - FADE_DISTANCE;
			_inner = _inner < 0 ? 0 : _inner;
			
			update();
		}
	}
}