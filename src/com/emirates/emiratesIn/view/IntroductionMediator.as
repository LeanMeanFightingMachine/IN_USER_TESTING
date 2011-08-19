package com.emirates.emiratesIn.view
{
	import flash.events.Event;
	import com.emirates.emiratesIn.controller.signals.StartTrainingSignal;
	import com.emirates.emiratesIn.view.components.IntroductionView;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author fraserhobbs
	 */
	public class IntroductionMediator extends Mediator
	{
		[Inject]
		public var view:IntroductionView;
		
		[Inject]
		public var startTrainingSignal : StartTrainingSignal;
		
		public function IntroductionMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			view.addEventListener(IntroductionView.START, startHandler);
			view.show();
		}

		private function startHandler(event : Event) : void
		{
			startTrainingSignal.dispatch();
			view.hide();
		}
	}
}