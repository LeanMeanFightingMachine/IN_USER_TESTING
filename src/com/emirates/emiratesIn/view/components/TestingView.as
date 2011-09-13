package com.emirates.emiratesIn.view.components
{
	import com.emirates.emiratesIn.display.video.VideoPlayer;
	import com.emirates.emiratesIn.display.ui.Feedback;
	import com.emirates.emiratesIn.display.ui.Popup;
	import com.emirates.emiratesIn.display.ui.QuestionScreen;
	import com.emirates.emiratesIn.display.ui.Screen;
	import com.emirates.emiratesIn.display.ui.Vignette;
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import com.emirates.emiratesIn.display.ui.events.PopupEvent;
	import com.emirates.emiratesIn.display.ui.events.ScreenEvent;
	import com.emirates.emiratesIn.enum.Config;
	import com.emirates.emiratesIn.enum.Dict;
	import com.emirates.emiratesIn.enum.Test;
	import com.emirates.emiratesIn.view.components.events.TestingEvent;
	import com.emirates.emiratesIn.vo.ResultQualativeAnswerVO;
	import com.emirates.emiratesIn.vo.TestVO;
	import com.emirates.emiratesIn.vo.UpdateVO;

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
		private var _testRetryPopup:Popup = new Popup();
		private var _testQuestionsScreen:QuestionScreen = new QuestionScreen();
		private var _vignette:Vignette = new Vignette();
		private var _feedback:Feedback = new Feedback();
		private var _video : VideoPlayer = new VideoPlayer(Config.VIDEO_PATH);
		private var _faces : Vector.<VideoPlayer> = new Vector.<VideoPlayer>();
		private var _face:VideoPlayer;
		
		private var _feedbackOn:Boolean;
		
		public function TestingView()
		{
			super();
			
			addChild(_video);
			
			var v:VideoPlayer;
			for (var j : int = 0; j < Config.FACES_PATHS.length; j++)
			{
				v = new VideoPlayer(Config.FACES_PATHS[j]);
				v.visible = false;
				addChild(v);
				_faces.push(v);
			}

			addChild(_vignette);
			
			addChild(_feedback);
			
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
			
			_testRetryPopup.heading = Dict.TESTING_TEST_RETRY_HEADING;
			_testRetryPopup.body = Dict.TESTING_TEST_RETRY_BODY;
			_testRetryPopup.button = Dict.TESTING_TEST_RETRY_BUTTON;
			_testRetryPopup.addEventListener(PopupEvent.COMPLETE, testRetryPopupComplete);
			addChild(_testRetryPopup);
			
			_testQuestionsScreen.heading = Dict.TESTING_TEST_QUESTIONS_HEADING;
			_testQuestionsScreen.body = Dict.TESTING_TEST_QUESTIONS_BODY;
			_testQuestionsScreen.button = Dict.TESTING_TEST_QUESTIONS_BUTTON;
			for (var i : int = 0; i < Config.TESTING_QUESTIONS.length; i++)
			{
				_testQuestionsScreen.ask(Config.TESTING_QUESTIONS[i]["id"], Config.TESTING_QUESTIONS[i]["question"], Config.TESTING_QUESTIONS[i]["min"], Config.TESTING_QUESTIONS[i]["max"]);
			}
			_testQuestionsScreen.addEventListener(ScreenEvent.NEXT, testQuestionsPopupComplete);
			addChild(_testQuestionsScreen);
		}
		
		override public function show() : void
		{
			super.show();
			
			_introScreen.show();
		}
		
		override protected function resize() : void
		{
			super.resize();
			
			_video.width = stage.stageWidth;
			_video.height = stage.stageHeight;
			
			for (var i : int = 0; i < _faces.length; i++)
			{
				_faces[i].width = stage.stageWidth;
				_faces[i].height = stage.stageHeight;
			}
		}
		
		public function test(vo:TestVO):void
		{
			Debug.log(">>> " + vo.type + " : " + vo.hold);
			
			switch(vo.type)
			{
				case Test.SET:
					_testIntroPopup.heading = "Test: Set Level";
					_testIntroPopup.body = "Hold at " + (Config.TESTING_BASE + vo.adjust) + "% attention for " + vo.hold + " secs";
				break;
				case Test.ENTRY:
					_testIntroPopup.heading = "Test: Entry Level";
					_testIntroPopup.body = "Hold at entry level plus " + vo.adjust + "% attention for " + vo.hold + " secs";
				break;
				case Test.OVERALL_AVERAGE:
					_testIntroPopup.heading = "Test: Overall Average";
					_testIntroPopup.body = "Hold at overall average level plus " + vo.adjust + "% attention for " + vo.hold + " secs";
				break;
				case Test.SAMPLE_AVERAGE:
					_testIntroPopup.heading = "Test: Sample Average";
					_testIntroPopup.body = "Hold at sample average level plus " + vo.adjust + "% attention for " + vo.hold + " secs";
				break;
			}

			_feedbackOn = vo.feedback;
			
			_testIntroPopup.show();
		}
		
		public function attention(value:int):void
		{
			
		}
		
		public function update(vo:UpdateVO):void
		{
			if (vo.hotspot)
			{
				if (_feedbackOn)
				{
					_feedback.show();
					_feedback.target(vo.target);
					_feedback.attention(vo.attention);
				}
				
				if (vo.hit)
				{
					_vignette.animateIn(vo.hold);
				}
				else
				{
					_vignette.animateOut();
				}
			}
		}
		
		public function hotspot():void
		{
			_face = _faces[int(Math.random() * _faces.length)];
			_face.visible = true;
			_face.play();
			
			_vignette.show();
		}
		
		public function end():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function success():void
		{
			_video.pause();
			_face.pause();
			
			_testSuccessPopup.show();
		}
		
		public function fail():void
		{
			_video.pause();
			_face.pause();
			
			_testFailPopup.show();
			_vignette.stop();
		}
		
		public function get answers():Vector.<ResultQualativeAnswerVO>
		{
			return _testQuestionsScreen.answers;
		}
		
		private function introScreenNextHandler(event : ScreenEvent) : void
		{
			_introScreen.hide();
			
			Debug.log("introScreenNextHandler");

			dispatchEvent(new TestingEvent(TestingEvent.FIRST));
		}
		
		private function next():void
		{
			_face.seek(0);
			_face.visible = false;
			
			_video.seek(0);
			
			_feedback.reset();
			_vignette.reset();
			
			_testQuestionsScreen.show();
		}
		
		private function testIntroPopupComplete(event : PopupEvent) : void
		{
			_testIntroPopup.hide();

			dispatchEvent(new TestingEvent(TestingEvent.START));
			
			_video.play();
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
		
		private function testRetryPopupComplete(event : PopupEvent) : void
		{
			_testRetryPopup.hide();
			
			dispatchEvent(new TestingEvent(TestingEvent.RETRY));
		}
		
		private function testQuestionsPopupComplete(event : ScreenEvent) : void
		{
			_testQuestionsScreen.hide();

			dispatchEvent(new TestingEvent(TestingEvent.TEST_COMPLETE));
		}
	}
}
