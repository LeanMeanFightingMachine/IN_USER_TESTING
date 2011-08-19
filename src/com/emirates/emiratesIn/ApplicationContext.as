package com.emirates.emiratesIn
{
	import com.emirates.emiratesIn.controller.signals.TrainingCompleteSignal;
	import com.emirates.emiratesIn.controller.commands.AttentionUpdatedCommand;
	import com.emirates.emiratesIn.controller.signals.AttentionUpdatedSignal;
	import com.emirates.emiratesIn.controller.signals.StartTrainingSignal;
	import com.emirates.emiratesIn.model.AttentionModel;
	import com.emirates.emiratesIn.model.ResultsModel;
	import com.emirates.emiratesIn.net.Attention;
	import com.emirates.emiratesIn.net.events.AttentionEvent;
	import com.emirates.emiratesIn.view.IntroductionMediator;
	import com.emirates.emiratesIn.view.TestMediator;
	import com.emirates.emiratesIn.view.TrainingMediator;
	import com.emirates.emiratesIn.view.components.IntroductionView;
	import com.emirates.emiratesIn.view.components.TestView;
	import com.emirates.emiratesIn.view.components.TrainingView;

	import org.robotlegs.mvcs.SignalContext;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author fraserhobbs
	 */
	public class ApplicationContext extends SignalContext
	{
		public function ApplicationContext(contextView : DisplayObjectContainer)
		{
			super(contextView);
		}
		
		override public function startup() : void
		{
			// Events to commands
			commandMap.mapEvent(AttentionEvent.UPDATED, AttentionUpdatedCommand, AttentionEvent);
			
			// Models
			injector.mapSingleton(AttentionModel);
			injector.mapSingleton(ResultsModel);

			// Signals
			injector.mapSingleton(AttentionUpdatedSignal);
			injector.mapSingleton(StartTrainingSignal);
			injector.mapSingleton(TrainingCompleteSignal);

			// Signals to commands
			//signalCommandMap.mapSignalClass(StartTrainingSignal, StartTrainingCommand);

			// Views
			mediatorMap.mapView(IntroductionView, IntroductionMediator);
			mediatorMap.mapView(TestView, TestMediator);
			mediatorMap.mapView(TrainingView, TrainingMediator);

			contextView.addChild(new IntroductionView());
			contextView.addChild(new TestView());
			contextView.addChild(new TrainingView());

			Attention.addEventListener(AttentionEvent.UPDATED, attentionUpdatedHandler);
			Attention.start();
		}

		private function attentionUpdatedHandler(event : AttentionEvent) : void
		{
			eventDispatcher.dispatchEvent(event);
		}
	}
}
