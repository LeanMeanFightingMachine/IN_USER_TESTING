package com.emirates.emiratesIn.model
{
	import com.emirates.emiratesIn.vo.HotspotVO;
	import com.emirates.emiratesIn.controller.signals.TestHotspotSignal;
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import com.emirates.emiratesIn.controller.signals.TestFailSignal;
	import com.emirates.emiratesIn.controller.signals.TestSuccessSignal;
	import com.emirates.emiratesIn.controller.signals.TestUpdateSignal;
	import com.emirates.emiratesIn.enum.Config;
	import com.emirates.emiratesIn.enum.Test;
	import com.emirates.emiratesIn.vo.AttentionVO;
	import com.emirates.emiratesIn.vo.UpdateVO;
	import com.emirates.emiratesIn.vo.TestVO;

	import org.robotlegs.mvcs.Actor;

	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	/**
	 * @author Fraser Hobbs
	 */
	public class TestModel extends Actor
	{
		[Inject]
		public var testUpdateSignal:TestUpdateSignal;
		
		[Inject]
		public var testSuccessSignal:TestSuccessSignal;
		
		[Inject]
		public var testFailSignal:TestFailSignal;
		
		[Inject]
		public var hotspotSignal:TestHotspotSignal;
		
		private var _delayTimer:Timer = new Timer(0,1);
		private var _testTimer:Timer = new Timer(Config.TESTING_DURATION * 1000, 1);
		private var _holdTimer:Timer = new Timer(0,1);
		private var _holdStamp:Number;
		private var _hotspotStamp:Number;
		private var _startStamp:Number;
		
		private var _type:String;
		private var _hold:int;
		private var _adjust:int;
		
		private var _target:Number;
		private var _on:Boolean = false;
		private var _hotspot:Boolean = false;
		
		private var _attention:AttentionVO;
		
		public function TestModel()
		{
			_testTimer.addEventListener(TimerEvent.TIMER_COMPLETE, testTimerCompleteHandler);
			_holdTimer.addEventListener(TimerEvent.TIMER_COMPLETE, holdTimerCompleteHandler);
			_delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, delayTimerCompleteHandler);
		}

		public function setup(test:TestVO):void
		{
			_type = test.type;
			_hold = test.hold;
			_adjust = test.adjust;
			
			_on = false;
		}
		
		public function start(attention:AttentionVO):void
		{
			_attention = attention;
			
			_startStamp = getTimer();
			
			_holdTimer.delay = _hold * 1000;
			
			_testTimer.reset();

			_delayTimer.delay = Config.TESTING_HOTSPOT_MAX_DELAY * Math.random() * 1000;
			_delayTimer.reset();
			_delayTimer.start();
			
			_on = true;
		}
		
		public function update(attention:AttentionVO):void
		{
			_attention = attention;
			
			if(_on)
			{
				var update : UpdateVO = new UpdateVO();
				update.attention = attention.raw;
				update.hold = _hold;
				update.target = _target;
				update.hotspot = _hotspot;
				update.time = getTimer() - _startStamp;
				
				Debug.log("attention: " + attention.raw + " target: " + _target);
				
				if (attention.raw >= _target)
				{
					update.hit = true;
					
					if(_hold == 0)
					{
						_on = false;
						_hotspot = false;
			
						_testTimer.reset();
						_holdTimer.reset();
						
						testSuccessSignal.dispatch(getTimer() - _hotspotStamp);
					}
					else if(!_holdTimer.running)
					{
						_holdStamp = getTimer();
						_holdTimer.start();
						update.held = 0;
					}
					else
					{
						update.held = getTimer() - _holdStamp;
					}
				}
				else
				{
					update.hit = false;
					
					if(_holdTimer.running)
					{
						_holdTimer.reset();
					}
				}
	
				testUpdateSignal.dispatch(update);
			}
		}
		
		private function hotspot():void
		{
			_hotspotStamp = getTimer();
			
			switch(_type)
			{
				case Test.SET :
					_target = Config.TESTING_BASE + _adjust;
				break;
				case Test.ENTRY :
					_target = _attention.raw + _adjust;
				break;
				case Test.OVERALL_AVERAGE :
					_target = _attention.overallAverage + _adjust;
				break;
				case Test.SAMPLE_AVERAGE :
					_target = _attention.sampleAverage + _adjust;
				break;
			}

			if (_target > 100) _target = 100;
			
			_testTimer.start();
			
			_hotspot = true;

			var vo : HotspotVO = new HotspotVO();
			vo.target = _target;
			vo.time = _holdTimer.delay;
			hotspotSignal.dispatch(vo);
		}
		
		private function delayTimerCompleteHandler(event : TimerEvent) : void
		{
			hotspot();
		}
		
		private function testTimerCompleteHandler(event : TimerEvent) : void
		{
			_on = false;
			_hotspot = false;
			
			_testTimer.reset();
			_holdTimer.reset();
			
			testFailSignal.dispatch();
		}
		
		private function holdTimerCompleteHandler(event : TimerEvent) : void
		{
			_on = false;
			_hotspot = false;
			
			_testTimer.reset();
			_holdTimer.reset();
			
			testSuccessSignal.dispatch(getTimer() - _hotspotStamp);
		}
	}
}
