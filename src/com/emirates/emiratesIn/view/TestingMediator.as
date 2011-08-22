package com.emirates.emiratesIn.view
{
	import com.emirates.emiratesIn.controller.signals.NoTestsSignal;
	import com.emirates.emiratesIn.controller.signals.TestingCompleteSignal;
	import com.emirates.emiratesIn.controller.signals.NextTestSignal;
	import com.emirates.emiratesIn.controller.signals.TestingStartSignal;
	import com.emirates.emiratesIn.view.components.TestingView;

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
		public var testingStartSignal:TestingStartSignal;
		
		[Inject]
		public var testingCompleteSignal:TestingCompleteSignal;
		
		[Inject]
		public var nextTestSignal:NextTestSignal;
		
		[Inject]
		public var noTestsSignal:NoTestsSignal;
		
		public function TestingMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			testingStartSignal.add( startHandler );
			nextTestSignal.add( nextTestSignalHandler );
			noTestsSignal.add( noTestsSignalHandler );
			
			view.addEventListener(Event.COMPLETE, viewCompleteHandler);
		}

		private function startHandler():void
		{
			view.show();
		}
		
		private function nextTestSignalHandler(value:Array):void
		{
			view.update(value);
		}
		
		private function noTestsSignalHandler():void
		{
			view.end();
		}
		
		private function viewCompleteHandler(event : Event) : void
		{
			view.hide();
			testingCompleteSignal.dispatch();
		}
	}
}
