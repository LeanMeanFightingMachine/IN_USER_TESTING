package com.emirates.emiratesIn.view
{
	import com.emirates.emiratesIn.controller.signals.TestRetrySignal;
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import com.emirates.emiratesIn.vo.ResultVO;
	import com.emirates.emiratesIn.controller.signals.TestUpdateSignal;
	import com.emirates.emiratesIn.vo.TestVO;
	import com.emirates.emiratesIn.controller.signals.AttentionUpdateSignal;
	import com.emirates.emiratesIn.controller.signals.GotNextStateSignal;
	import com.emirates.emiratesIn.controller.signals.GotNextTestSignal;
	import com.emirates.emiratesIn.controller.signals.NoTestsSignal;
	import com.emirates.emiratesIn.controller.signals.StateCompleteSignal;
	import com.emirates.emiratesIn.controller.signals.TestCompleteSignal;
	import com.emirates.emiratesIn.controller.signals.TestFailSignal;
	import com.emirates.emiratesIn.controller.signals.TestStartSignal;
	import com.emirates.emiratesIn.controller.signals.TestSuccessSignal;
	import com.emirates.emiratesIn.enum.State;
	import com.emirates.emiratesIn.view.components.TestingView;
	import com.emirates.emiratesIn.view.components.events.TestingEvent;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.Event;

	/**
	 * @author fraserhobbs
	 */
	public class TestingMediator extends Mediator
	{
		[Inject]
		public var view:TestingView;
		
		[Inject]
		public var nextStateSignal : GotNextStateSignal;
		
		[Inject]
		public var stateCompleteSignal : StateCompleteSignal;
		
		[Inject]
		public var gotNextTestSignal:GotNextTestSignal;
		
		[Inject]
		public var noTestsSignal:NoTestsSignal;
		
		[Inject]
		public var testCompleteSignal:TestCompleteSignal;
		
		[Inject]
		public var attentionUpdatedSignal:AttentionUpdateSignal;
		
		[Inject]
		public var testSuccessSignal:TestSuccessSignal;
		
		[Inject]
		public var testFailSignal:TestFailSignal;
		
		[Inject]
		public var testStartSignal:TestStartSignal;
		
		[Inject]
		public var testRetrySignal:TestRetrySignal;
		
		[Inject]
		public var testUpdateSignal:TestUpdateSignal;
		
		public function TestingMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			nextStateSignal.add( stateHandler );
			
			gotNextTestSignal.add( gotNextTestSignalHandler );
			noTestsSignal.add( noTestsSignalHandler );
			attentionUpdatedSignal.add( attentionUpdatedHandler );
			testUpdateSignal.add( testUpdateHandler );
			
			testFailSignal.add( testFailHandler );
			testSuccessSignal.add( testSuccessHandler );
			
			view.addEventListener(Event.COMPLETE, viewCompleteHandler);
			view.addEventListener(TestingEvent.NEXT, testingNextHandler);
			view.addEventListener(TestingEvent.START, testingStartHandler);
			view.addEventListener(TestingEvent.RETRY, testingRetryHandler);
		}

		private function stateHandler(value:String):void
		{
			if (value == State.TESTING)
			{
				view.show();
			}
		}
		
		private function gotNextTestSignalHandler(vo:TestVO):void
		{
			view.test(vo);
		}
		
		private function noTestsSignalHandler():void
		{
			view.end();
		}
		
		private function testUpdateHandler(vo:ResultVO):void
		{
			Debug.log("testUpdateHandler " + vo.attention);
		}
		
		private function testSuccessHandler():void
		{
			Debug.log("testSuccessHandler");
			view.success();
		}
		
		private function testFailHandler():void
		{
			Debug.log("testFailHandler");
			
			view.fail();
		}
		
		private function attentionUpdatedHandler(value:int):void
		{
			view.attention(value);
		}
		
		private function testingNextHandler(event : TestingEvent) : void
		{
			testCompleteSignal.dispatch();
		}
		
		private function testingStartHandler(event : TestingEvent) : void
		{
			testStartSignal.dispatch();
		}
		
		private function viewCompleteHandler(event : Event) : void
		{
			view.hide();
			stateCompleteSignal.dispatch();
		}
		
		private function testingRetryHandler(event : TestingEvent) : void
		{
			testRetrySignal.dispatch();
		}
	}
}
