package com.emirates.emiratesIn.display.ui
{
	import flash.display.Sprite;

	/**
	 * @author fraserhobbs
	 */
	public class Balloon extends Sprite
	{
		private var _asset:BalloonAsset = new BalloonAsset();
		
		public function Balloon(scale:Number)
		{
			addChild(_asset);
			_asset.scaleX = scale;
			_asset.scaleY = scale;
		}
		
		public function set scale(value:Number):void
		{
			_asset.scaleX = value;
			_asset.scaleY = value;
		}
		
		public function get scale():Number
		{
			return _asset.scaleX;
		}
	}
}
