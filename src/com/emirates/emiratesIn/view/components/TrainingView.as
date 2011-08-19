package com.emirates.emiratesIn.view.components
{
	import com.emirates.emiratesIn.display.ui.events.ScreenEvent;
	import com.emirates.emiratesIn.display.ui.Screen;
	import com.emirates.emiratesIn.display.ui.GameOne;
	import com.emirates.emiratesIn.display.ui.GameTwo;
	import com.emirates.emiratesIn.display.ui.Popup;
	import com.emirates.emiratesIn.display.ui.events.GameEvent;
	import com.emirates.emiratesIn.display.ui.events.PopupEvent;
	import com.emirates.emiratesIn.enum.Config;
	import com.emirates.emiratesIn.enum.Dict;

	/**
	 * @author fraserhobbs
	 */
	public class TrainingView extends View
	{
		private var _introScreen:Screen = new Screen();
		private var _gameOne:GameOne = new GameOne();
		private var _gameOneIntroPopup:Popup = new Popup();
		private var _gameOneSuccessPopup:Popup = new Popup();
		private var _gameOneFailPopup:Popup = new Popup();
		
		private var _gameTwo:GameTwo = new GameTwo();
		private var _gameTwoIntroPopup:Popup = new Popup();
		private var _gameTwoSuccessPopup:Popup = new Popup();
		
		private var _part:int = 0;
		private var _level:int = 1;
		
		public function TrainingView()
		{
			visible = false;

			_introScreen.heading = Dict.TRAINING_INTRO_HEADING;
			_introScreen.body = Dict.TRAINING_INTRO_BODY;
			_introScreen.button = Dict.TRAINING_INTRO_BUTTON;
			_introScreen.addEventListener(ScreenEvent.NEXT, introScreenNextHandler);
			addChild(_introScreen);
			
			_gameOne.addEventListener(GameEvent.SUCCESS, gameOneSuccessHandler);
			_gameOne.addEventListener(GameEvent.FAIL, gameOneFailHandler);
			addChild(_gameOne);
			
			_gameTwo.addEventListener(GameEvent.SUCCESS, gameTwoSuccessHandler);
			addChild(_gameTwo);

			_gameOneIntroPopup.heading = Dict.TRAINING_GAME_ONE_INTRO_HEADING;
			_gameOneIntroPopup.body = Dict.TRAINING_GAME_ONE_INTRO_BODY;
			_gameOneIntroPopup.button = Dict.TRAINING_GAME_ONE_INTRO_BUTTON;
			_gameOneIntroPopup.addEventListener(PopupEvent.COMPLETE, gameOneIntroPopupComplete);
			addChild(_gameOneIntroPopup);

			_gameOneFailPopup.heading = Dict.TRAINING_GAME_ONE_FAIL_HEADING;
			_gameOneFailPopup.body = Dict.TRAINING_GAME_ONE_FAIL_BODY;
			_gameOneFailPopup.button = Dict.TRAINING_GAME_ONE_FAIL_BUTTON;
			_gameOneFailPopup.addEventListener(PopupEvent.COMPLETE, gameOneFailPopupComplete);
			addChild(_gameOneFailPopup);

			_gameOneSuccessPopup.heading = Dict.TRAINING_GAME_ONE_SUCCESS_HEADING;
			_gameOneSuccessPopup.body = Dict.TRAINING_GAME_ONE_SUCCESS_BODY;
			_gameOneSuccessPopup.button = Dict.TRAINING_GAME_ONE_SUCCESS_BUTTON;
			_gameOneSuccessPopup.addEventListener(PopupEvent.COMPLETE, gameOneSuccessPopupComplete);
			addChild(_gameOneSuccessPopup);

			_gameTwoIntroPopup.addEventListener(PopupEvent.COMPLETE, gameTwoIntroPopupComplete);
			_gameTwoIntroPopup.heading = Dict.TRAINING_GAME_TWO_INTRO_HEADING;
			_gameTwoIntroPopup.body = Dict.TRAINING_GAME_TWO_INTRO_BODY;
			_gameTwoIntroPopup.button = Dict.TRAINING_GAME_TWO_INTRO_BUTTON;
			addChild(_gameTwoIntroPopup);
			
			_gameTwoSuccessPopup.heading = Dict.TRAINING_GAME_ONE_SUCCESS_HEADING;
			_gameTwoSuccessPopup.body = Dict.TRAINING_GAME_ONE_SUCCESS_BODY;
			_gameTwoSuccessPopup.button = Dict.TRAINING_GAME_ONE_SUCCESS_BUTTON;
			_gameTwoSuccessPopup.addEventListener(PopupEvent.COMPLETE, gameTwoSuccessPopupComplete);
			addChild(_gameTwoSuccessPopup);
		}

		public function attention(value:int):void
		{
			_gameOne.attention(value);
			_gameTwo.attention(value);
		}

		override public function show() : void
		{
			super.show();
			
			_introScreen.show();
		}
		
		private function gameOneStart():void
		{
			_part = 1;
			
			_gameOne.show();
			
			gameOneLevel(_level);
		}
		
		private function gameOneLevel(level:int):void
		{
			_gameOne.setup(Config.TRAINING_GAME_ONE_BASE + (Config.TRAINING_GAME_ONE_LEVEL_INCREMENT * (level - 1)));

			_gameOneIntroPopup.heading = Dict.TRAINING_GAME_ONE_INTRO_HEADING + level;
			_gameOneIntroPopup.show();
		}
		
		private function introScreenNextHandler(event : ScreenEvent) : void
		{
			_introScreen.hide();
			
			gameOneStart();
		}

		private function gameOneFailHandler(event : GameEvent) : void
		{
			_gameOneFailPopup.show();
		}

		private function gameOneSuccessHandler(event : GameEvent) : void
		{
			_gameOneSuccessPopup.show();
		}
		
		private function gameTwoSuccessHandler(event : GameEvent) : void
		{
			_gameTwoSuccessPopup.show();
		}

		private function gameOneIntroPopupComplete(event : PopupEvent) : void
		{
			_gameOneIntroPopup.hide();
			_gameOne.start();
		}
		
		private function gameTwoIntroPopupComplete(event : PopupEvent) : void
		{
			_gameTwoIntroPopup.hide();
			
			_gameTwo.start();
		}
		
		private function gameOneSuccessPopupComplete(event : PopupEvent) : void
		{
			_gameOneSuccessPopup.hide();

			if (_level < Config.TRAINING_GAME_ONE_LEVELS)
			{
				gameOneLevel(++_level);
			}
			else
			{
				_gameOne.hide();

				_gameTwo.setup(Config.TRAINING_GAME_TWO_TARGET, Config.TRAINING_GAME_TWO_HOLD);
				_gameTwo.show();
				
				_gameTwoIntroPopup.show();
			}
		}

		private function gameOneFailPopupComplete(event : PopupEvent) : void
		{
			_gameOneFailPopup.hide();
			gameOneLevel(_level);
		}
		
		private function gameTwoSuccessPopupComplete(event : PopupEvent) : void
		{
			_gameTwoSuccessPopup.hide();
		}

	}
}
