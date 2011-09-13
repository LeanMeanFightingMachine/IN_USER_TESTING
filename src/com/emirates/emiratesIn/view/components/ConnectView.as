package com.emirates.emiratesIn.view.components
{
	import flash.display.Shape;
	import com.emirates.emiratesIn.display.ui.Screen;
	import com.emirates.emiratesIn.display.ui.events.ScreenEvent;
	import com.emirates.emiratesIn.enum.Dict;

	import flash.events.Event;
	/**
	 * @author Fraser Hobbs
	 */
	public class ConnectView extends View
	{
		private var _screen:Screen = new Screen();
		
		private var _indicator:Shape = new Shape();
		
		public function ConnectView()
		{
			_screen.heading = Dict.CONNECT_INTRO_HEADING;
			_screen.body = Dict.CONNECT_INTRO_BODY;
			_screen.button = Dict.CONNECT_INTRO_BUTTON;
			_screen.addEventListener(ScreenEvent.NEXT, introScreenNextHandler);
			addChild(_screen);
			
			addChild(_indicator);
			
			disconnected();
		}
		
		override public function show() : void
		{
			super.show();
			
			_screen.show();
		}
		
		public function connected():void
		{
			_indicator.graphics.clear();
			_indicator.graphics.beginFill(0x00FF00);
			_indicator.graphics.drawCircle(0, 0, 100);
			_indicator.graphics.endFill();
		}
		
		public function disconnected():void
		{
			_indicator.graphics.clear();
			_indicator.graphics.beginFill(0xFF0000);
			_indicator.graphics.drawCircle(0, 0, 100);
			_indicator.graphics.endFill();
		}
		
		override protected function resize() : void
		{
			_indicator.x = int(stage.stageWidth * 0.5);
			_indicator.y = int(stage.stageHeight * 0.5);
		}

		private function introScreenNextHandler(event : ScreenEvent) : void
		{
			_screen.hide();

			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}
