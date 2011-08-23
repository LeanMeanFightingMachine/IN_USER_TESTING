package com.emirates.emiratesIn.display.ui
{
	import com.greensock.TweenMax;

	/**
	 * @author Fraser Hobbs
	 */
	public class Vignette extends Clip
	{
		private var _growing:Boolean = false;
		
		public function Vignette()
		{
			super();
		}
		
		public function reset():void
		{
			scaleX = 1;
			scaleY = 1;
			
			hide();
		}
		
		public function animateIn(duration:Number):void
		{
			if (!_growing)
			{
				_growing = true;
					
				TweenMax.killTweensOf(this);
				TweenMax.to(this, duration, {scaleX:0, scaleY:0});
			}
		}
		
		public function animateOut():void
		{
			if (_growing)
			{
				_growing = false;
				
				TweenMax.killTweensOf(this);
				TweenMax.to(this, 1, {scaleX:1, scaleY:1});
			}
		}
			
		override protected function resize() : void
		{
			super.resize();
			
			x = int(stage.stageWidth * 0.5);
			y = int(stage.stageHeight * 0.5);
			
			graphics.clear();
			graphics.beginFill(0x000000);
			graphics.drawEllipse(-int(stage.stageWidth * 0.5), -int(stage.stageHeight * 0.5), stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			update();
		}
	}
}