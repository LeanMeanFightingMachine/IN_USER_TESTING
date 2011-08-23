package com.emirates.emiratesIn.view
{
	import com.emirates.emiratesIn.controller.signals.GotNextStateSignal;
	import com.emirates.emiratesIn.controller.signals.StateCompleteSignal;
	import com.emirates.emiratesIn.enum.State;
	import com.emirates.emiratesIn.view.components.IntroductionView;

	import org.robotlegs.mvcs.Mediator;

	import flash.events.Event;

	/**
	 * @author fraserhobbs
	 */
	public class IntroductionMediator extends Mediator
	{
		[Inject]
		public var view:IntroductionView;
		
		[Inject]
		public var nextStateSignal : GotNextStateSignal;
		
		[Inject]
		public var stateCompleteSignal : StateCompleteSignal;
		
		public function IntroductionMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			nextStateSignal.add( stateHandler );
			
			view.addEventListener(Event.COMPLETE, viewCompleteHandler);
		}
		
		private function stateHandler(value:String):void
		{
			if (value == State.INTRODUCTION)
			{
				view.show();
			}
		}
		
		private function viewCompleteHandler(event : Event) : void
		{
			view.hide();
			stateCompleteSignal.dispatch();
		}
	}
}