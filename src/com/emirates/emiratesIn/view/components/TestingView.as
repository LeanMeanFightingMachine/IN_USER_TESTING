package com.emirates.emiratesIn.view.components
{
	import com.emirates.emiratesIn.display.ui.Popup;
	import com.emirates.emiratesIn.display.ui.Screen;
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import com.emirates.emiratesIn.display.ui.events.PopupEvent;
	import com.emirates.emiratesIn.display.ui.events.ScreenEvent;
	import com.emirates.emiratesIn.enum.Dict;
	import com.emirates.emiratesIn.view.components.events.TestingEvent;
	import com.emirates.emiratesIn.vo.TestVO;

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
		
		private var _feedback:Boolean = false;
		
		public function TestingView()
		{
			super();
			
			_introScreen.heading = Dict.TESTING_INTRO_HEADING;
			_introScreen.body = Dict.TESTING_INTRO_BODY;
			_introScreen.button = Dict.TESTING_INTRO_BUTTON;
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
			
			_testFailPopup.heading = Dict.TESTING_TEST_FAIL_HEADING;
			_testFailPopup.body = Dict.TESTING_TEST_FAIL_BODY;
			_testFailPopup.button = Dict.TESTING_TEST_FAIL_BUTTON;
			_testFailPopup.addEventListener(PopupEvent.COMPLETE, testFailPopupComplete);
			addChild(_testFailPopup);
		}
		
		override public function show() : void
		{
			super.show();
			
			_introScreen.show();
		}
		
		public function test(vo:TestVO):void
		{
			Debug.log(">>> " + vo.type + " : " + vo.hold);

			_testIntroPopup.show();
		}
		
		public function attention(value:int):void
		{
			
		}
		
		public function end():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function success():void
		{
			_testSuccessPopup.show();
		}
		
		public function fail():void
		{
			_testFailPopup.show();
		}
		
		private function introScreenNextHandler(event : ScreenEvent) : void
		{
			_introScreen.hide();
			
			Debug.log("introScreenNextHandler");
			
			dispatchEvent(new TestingEvent(TestingEvent.NEXT));
		}
		
		private function next():void
		{
			if(_feedback)
			{
				dispatchEvent(new TestingEvent(TestingEvent.NEXT));
			}
			else
			{
				dispatchEvent(new TestingEvent(TestingEvent.RETRY));
			}
			
			_feedback = !_feedback;
		}
		
		private function testIntroPopupComplete(event : PopupEvent) : void
		{
			_testIntroPopup.hide();

			dispatchEvent(new TestingEvent(TestingEvent.START));
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
