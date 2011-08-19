package com.emirates.emiratesIn.view.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.bit101.components.PushButton;
	import flash.display.Sprite;

	/**
	 * @author fraserhobbs
	 */
	public class IntroductionView extends View
	{
		public static const START:String = "IntroductionView_start";
		
		private var _startButton:PushButton = new PushButton();
		
		public function IntroductionView()
		{
			addChild(_startButton);
			_startButton.label = "Start";
			_startButton.addEventListener(MouseEvent.CLICK, startButtonClickHandler);
		}
		
		override protected function resize():void
		{
			_startButton.x = (stage.stageWidth - _startButton.width) * 0.5;
			_startButton.y = stage.stageHeight - 50;
		}
		
		private function startButtonClickHandler(event : MouseEvent) : void
		{
			dispatchEvent(new Event(START));
		}
	}
}
