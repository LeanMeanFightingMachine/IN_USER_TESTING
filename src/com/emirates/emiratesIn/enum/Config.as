package com.emirates.emiratesIn.enum
{
	/**
	 * @author Fraser Hobbs
	 */
	public class Config
	{
		//public static const STATES : Array = [State.CONNECT, State.INTRODUCTION, State.TRAINING, State.TESTING];
		public static const STATES : Array = [State.TESTING];
		
		public static const TRAINING_GAME_ONE_LEVEL_INCREMENT:int = 10;
		public static const TRAINING_GAME_ONE_BASE:int = 50;
		public static const TRAINING_GAME_ONE_LEVELS:int = 3;
		public static const TRAINING_GAME_TWO_HOLD:int = 5;
		public static const TRAINING_GAME_TWO_TARGET:int = 60;
		
		public static const TESTING_HOLD : Array = [0,3,5];
		//public static const TESTING_HOLD : Array = [0];
		public static const TESTING_TESTS:Array = [Test.SET,Test.ENTRY,Test.OVERALL_AVERAGE,Test.SAMPLE_AVERAGE];
		//public static const TESTING_TESTS : Array = [Test.ENTRY];
		public static const TESTING_BASE:int = 60;
		public static const TESTING_INCREMENT:int = 10;
		public static const TESTING_LEVELS:int = 2;
		public static const TESTING_SAMPLE_SIZE:int = 100;
		public static const TESTING_DURATION:int = 10;
		public static const TESTING_HOTSPOT_MIN_DELAY : int = 2;
		public static const TESTING_HOTSPOT_MAX_DELAY : int = 6;
		public static const TESTING_QUESTIONS : Array = [Questions.ENJOYABLE, Questions.DIFFICULT, Questions.CONTROL];
		public static const VIDEO_PATH:String = "video/main.mp4";
		public static const FACES_PATHS:Array = ["video/girl.f4v", "video/man.f4v", "video/nurse.f4v", "video/oldman.f4v", "video/woman.f4v"];
		public static const DATABASE_NAME:String = "results";
	}
}