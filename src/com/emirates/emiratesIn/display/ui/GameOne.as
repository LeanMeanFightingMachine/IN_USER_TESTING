package com.emirates.emiratesIn.display.ui
{
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import com.emirates.emiratesIn.display.ui.events.GameEvent;
	import com.emirates.emiratesIn.utils.Collision;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import flash.display.Shape;

	/**
	 * @author fraserhobbs
	 */
	public class GameOne extends Clip
	{
		public var att:Number = 0;
		public var dis:Number = 0;
		
		private var _target:int;
		private var _balloon:Balloon = new Balloon(0.1);
		private var _active:Boolean;
		private var _sky:SkyAsset = new SkyAsset();
		private var _statue:StatueAsset = new StatueAsset();
		
		public function GameOne()
		{
			addChild(_sky);
			addChild(_statue);
			addChild(_balloon);
		}
		
		public function setup(target:int):void
		{
			_target = target;
			
			att = 0;
			dis = 0;
			
			disUpdate();
		}
		
		public function start():void
		{
			Debug.log("start");
			
			_active = true;
			
			TweenMax.to(this, 10, {dis:1, onUpdate:disUpdate, onComplete:disComplete, ease:Linear.easeNone});
		}
		
		public function attention(attention:int):void
		{
			if(_active)
			{
				TweenMax.to(this, 1, {att:attention, ease:Linear.easeNone});
			}
		}
			
		override protected function resize() : void
		{
			var w:int = _sky.width / _sky.scaleX;
			var h:int = _sky.height / _sky.scaleY;
			
			var rw:Number = stage.stageWidth / w;
			var rh:Number = stage.stageHeight / h;
			var r:Number = rw > rh ? rw : rh;
			
			_sky.scaleX = r;
			_sky.scaleY = r;

			_sky.x = (stage.stageWidth - _sky.width) * 0.5;
			_sky.y = (stage.stageHeight - _sky.height) * 0.5;
			
			positionObjects();
		}
		
		private function disUpdate():void
		{
			positionObjects();

			if (att < _target)
			{
				if (Collision.detect(this, _balloon, _statue, false, true))
				{
					TweenMax.killTweensOf(this);
					
					_active = false;
					
					dispatchEvent(new GameEvent(GameEvent.FAIL));
				}
			}
		}
		
		private function positionObjects():void
		{
			var flightHeight:Number = stage.stageHeight - _balloon.height;
			
			_balloon.x = stage.stageWidth * dis;
			_balloon.y = flightHeight - (flightHeight * (att / 100));

			var wallHeight:Number = flightHeight * (_target / 100);

			_statue.height = wallHeight;
			_statue.scaleX = _statue.scaleY;
			
			_statue.x = (stage.stageWidth - _statue.width) * 0.5;
			_statue.y = stage.stageHeight - wallHeight;
		}
		
		private function disComplete():void
		{
			Debug.log("disComplete");
			
			_active = false;
			
			dispatchEvent(new GameEvent(GameEvent.SUCCESS));
		}
		
	}
}
