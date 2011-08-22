package com.emirates.emiratesIn.view.components
{
	import com.emirates.emiratesIn.display.ui.Popup;
	import com.emirates.emiratesIn.display.ui.Screen;
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import com.emirates.emiratesIn.display.ui.events.PopupEvent;
	import com.emirates.emiratesIn.display.ui.events.ScreenEvent;
	import com.emirates.emiratesIn.enum.Dict;
	import com.emirates.emiratesIn.view.components.events.TestingEvent;

	import flash.events.Event;

	/**
	 * @author fraserhobbs
	 */
	public class TestingView extends View
	{
		private var _introScreen:Screen = new Screen();
		private var _testIntroPopup:Popup = new Popup();
		private var _testSuccessPopup:Popup = new Popup();
		private var _testFailPopup:Popup = new Popup();
		
		public function TestingView()
		{
			super();
			
			_introScreen.heading = Dict.TRAINING_INTRO_HEADING;
			_introScreen.body = Dict.TRAINING_INTRO_BODY;
			_introScreen.button = Dict.TRAINING_INTRO_BUTTON;
			_introScreen.addEventListener(ScreenEvent.NEXT, introScreenNextHandler);
			addChild(_introScreen);
			
			_testIntroPopup.heading = Dict.TESTING_TEST_INTRO_HEADING;
			_testIntroPopup.body = Dict.TESTING_TEST_INTRO_BODY;
			_testIntroPopup.button = Dict.TESTING_TEST_INTRO_BUTTON;
			_testIntroPopup.addEventListener(PopupEvent.COMPLETE, testIntroPopupComplete);
			addChild(_testIntroPopup);
			
			_testSuccessPopup.heading = Dict.TESTING_TEST_SUCCESS_HEADING;
			_testSuccessPopup.body = Dict.TESTING_TEST_SUCCESS_BODY;
			_testSuccessPopup.button = Dict.TESTING_TEST_SUCCESS_BUTTON;
			_testSuccessPopup.addEventListener(PopupEvent.COMPLETE, testSuccessPopupComplete);
			addChild(_testSuccessPopup);
			
			_testFailPopup.heading = Dict.TESTING_TEST_SUCCESS_HEADING;
			_testFailPopup.body = Dict.TESTING_TEST_SUCCESS_BODY;
			_testFailPopup.button = Dict.TESTING_TEST_SUCCESS_BUTTON;
			_testFailPopup.addEventListener(PopupEvent.COMPLETE, testFailPopupComplete);
			addChild(_testFailPopup);
		}
		
		override public function show() : void
		{
			super.show();
			
			_testIntroPopup.show();
		}
		
		public function update(value:Array):void
		{
			Debug.log(">>> " + value[0] + " : " + value[1]);

			_testIntroPopup.show();
		}
		
		public function end():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function introScreenNextHandler(event : ScreenEvent) : void
		{
			_introScreen.hide();
			
			next();
		}
		
		private function next():void
		{
			dispatchEvent(new TestingEvent(TestingEvent.NEXT));
		}
		
		private function testIntroPopupComplete(event : PopupEvent) : void
		{
			_testIntroPopup.hide();
			
			next();
		}
		
		private function testSuccessPopupComplete(event : PopupEvent) : void
		{
			_testSuccessPopup.hide();
			
			next();
		}
		
		private function testFailPopupComplete(event : PopupEvent) : void
		{
			_testFailPopup.hide();
			
			next();
		}
	}
}
