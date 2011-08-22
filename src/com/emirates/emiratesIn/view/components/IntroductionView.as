package com.emirates.emiratesIn.view.components
{
	import com.emirates.emiratesIn.display.ui.Screen;
	import com.emirates.emiratesIn.display.ui.events.ScreenEvent;
	import com.emirates.emiratesIn.enum.Dict;

	import flash.events.Event;

	/**
	 * @author fraserhobbs
	 */
	public class IntroductionView extends View
	{
		private var _introScreen:Screen = new Screen();
		
		public function IntroductionView()
		{
			_introScreen.heading = Dict.INTRODUCTION_INTRO_HEADING;
			_introScreen.body = Dict.INTRODUCTION_INTRO_BODY;
			_introScreen.button = Dict.INTRODUCTION_INTRO_BUTTON;
			_introScreen.addEventListener(ScreenEvent.NEXT, introScreenNextHandler);
			addChild(_introScreen);
		}
		
		override public function show() : void
		{
			super.show();
			
			_introScreen.show();
		}

		private function introScreenNextHandler(event : ScreenEvent) : void
		{
			_introScreen.hide();

			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}
