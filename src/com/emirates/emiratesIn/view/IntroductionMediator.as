package com.emirates.emiratesIn.view
{
	import com.emirates.emiratesIn.controller.signals.IntroductionCompleteSignal;
	import com.emirates.emiratesIn.controller.signals.IntroductionStartSignal;
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
		public var introductionStartSignal : IntroductionStartSignal;
		
		[Inject]
		public var introductionCompleteSignal : IntroductionCompleteSignal;
		
		public function IntroductionMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			introductionStartSignal.add( startHandler );
			
			view.addEventListener(Event.COMPLETE, viewCompleteHandler);
		}
		
		private function startHandler():void
		{
			view.show();
		}
		
		private function viewCompleteHandler(event : Event) : void
		{
			view.hide();
			introductionCompleteSignal.dispatch();
		}
	}
}