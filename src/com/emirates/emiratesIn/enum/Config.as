package com.emirates.emiratesIn.enum
{
	/**
	 * @author Fraser Hobbs
	 */
	public class Config
	{
		public static const TRAINING_GAME_ONE_LEVEL_INCREMENT:int = 10;
		public static const TRAINING_GAME_ONE_BASE:int = 50;
		public static const TRAINING_GAME_ONE_LEVELS:int = 1;
		public static const TRAINING_GAME_TWO_HOLD:int = 5;
		public static const TRAINING_GAME_TWO_TARGET:int = 50;
		
		public static const TESTING_HOLD : Array = [0,1,2,3,4,5];
		public static const TESTING_TESTS:Array = [Test.SET,Test.ENTRY,Test.OVERALL_AVERAGE,Test.SAMPLE_AVERAGE];
		public static const TESTING_BASE:int = 50;
		public static const TESTING_INCREMENT:int = 10;
		public static const TESTING_LEVELS:int = 3;
	}
}