package com.emirates.emiratesIn.display.ui
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import com.emirates.emiratesIn.display.ui.events.GameEvent;
	import com.greensock.TweenMax;

	/**
	 * @author fraserhobbs
	 */
	public class GameTwo extends Clip
	{
		private var _brickwall:BrickwallAsset = new BrickwallAsset();
		private var _balloon:Balloon = new Balloon(0.1);
		private var _bang:BangAsset = new BangAsset();
		private var _target:int;
		private var _duration:int;
		private var _growing:Boolean;
		private var _active:Boolean;
		private var _pause:Timer = new Timer(1000,1);
		
		public function GameTwo()
		{
			super();
			
			addChild(_brickwall);
			addChild(_balloon);
			addChild(_bang);
			
			_pause.addEventListener(TimerEvent.TIMER_COMPLETE, pauseTimerCompleteHandler);
			
			_bang.visible = false;
		}
		
		public function setup(target:int, duration:int):void
		{
			_target = target;
			_duration = duration;
		}
		
		public function start():void
		{
			_active = true;
		}
		
		public function attention(attention:int):void
		{
			if(_active)
			{
				Debug.log("attention " + attention);
				Debug.log("_growing " + _growing);
				
				if (attention >= _target && !_growing)
				{
					_growing = true;
					
					TweenMax.killTweensOf(_balloon);
					TweenMax.to(_balloon, _duration, {scale:1, onUpdate:positionBalloon, onComplete:inflateComplete});
				}
				else if(attention < _target && _growing)
				{
					_growing = false;
					
					TweenMax.killTweensOf(_balloon);
					TweenMax.to(_balloon, _duration, {scale:0.1, onUpdate:positionBalloon});
				}
			}
		}
			
		override protected function resize() : void
		{
			var w : int = _brickwall.width / _brickwall.scaleX;
			var h:int = _brickwall.height / _brickwall.scaleY;
			
			var rw:Number = stage.stageWidth / w;
			var rh:Number = stage.stageHeight / h;
			var r:Number = rw > rh ? rw : rh;
			
			_brickwall.scaleX = r;
			_brickwall.scaleY = r;

			_brickwall.x = (stage.stageWidth - _brickwall.width) * 0.5;
			_brickwall.y = (stage.stageHeight - _brickwall.height) * 0.5;

			positionBalloon();
			
			if(_bang.visible)
			{
				_bang.x = (stage.stageWidth - _bang.width) * 0.5;
				_bang.y = (stage.stageHeight - _bang.height) * 0.5;
			}
		}
		
		private function positionBalloon():void
		{
			_balloon.x = (stage.stageWidth - _balloon.width) * 0.5;
			_balloon.y = (stage.stageHeight - _balloon.height) * 0.5;
		}
		
		private function inflateComplete():void
		{
			_active = false;
			
			_bang.x = (stage.stageWidth - _bang.width) * 0.5;
			_bang.y = (stage.stageHeight - _bang.height) * 0.5;
			_bang.visible = true;
			
			_balloon.visible = false;

			_pause.reset();
			_pause.start();
		}
		
		private function pauseTimerCompleteHandler(event : TimerEvent) : void
		{
			dispatchEvent(new GameEvent(GameEvent.SUCCESS));
		}
	}
}
