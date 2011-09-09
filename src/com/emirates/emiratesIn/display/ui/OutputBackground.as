package com.emirates.emiratesIn.display.ui
{

	/**
	 * @author Fraser Hobbs
	 */
	public class OutputBackground extends Clip
	{
		public function OutputBackground()
		{
			super();
		}
		
		override protected function resize():void
		{
			update();
		}
			
		override protected function draw() : void
		{
			graphics.clear();
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
		}
	}
}
