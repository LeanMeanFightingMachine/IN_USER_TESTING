package com.emirates.emiratesIn.vo
{
	/**
	 * @author fraserhobbs
	 */
	public class ResultVO
	{
		public var type:String;
		public var level:int;
		public var hold:int;
		public var position:int;
		public var target:int;
		public var quantative:ResultQuantativeVO = new ResultQuantativeVO();
		public var qualative:ResultQualativeVO = new ResultQualativeVO();
	}
}
