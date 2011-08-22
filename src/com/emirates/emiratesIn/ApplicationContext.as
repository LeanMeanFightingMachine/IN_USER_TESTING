package com.emirates.emiratesIn
{
	import com.emirates.emiratesIn.controller.signals.NoTestsSignal;
	import com.emirates.emiratesIn.controller.signals.NextTestSignal;
	import com.emirates.emiratesIn.controller.commands.AttentionUpdatedCommand;
	import com.emirates.emiratesIn.controller.commands.IntroductionCompleteCommand;
	import com.emirates.emiratesIn.controller.commands.StartupCommand;
	import com.emirates.emiratesIn.controller.commands.TestingCompleteCommand;
	import com.emirates.emiratesIn.controller.commands.TestingStartCommand;
	import com.emirates.emiratesIn.controller.commands.TrainingCompleteCommand;
	import com.emirates.emiratesIn.controller.signals.AttentionUpdatedSignal;
	import com.emirates.emiratesIn.controller.signals.IntroductionCompleteSignal;
	import com.emirates.emiratesIn.controller.signals.IntroductionStartSignal;
	import com.emirates.emiratesIn.controller.signals.TestingCompleteSignal;
	import com.emirates.emiratesIn.controller.signals.TestingStartSignal;
	import com.emirates.emiratesIn.controller.signals.TrainingCompleteSignal;
	import com.emirates.emiratesIn.controller.signals.TrainingStartSignal;
	import com.emirates.emiratesIn.model.AttentionModel;
	import com.emirates.emiratesIn.model.ResultsModel;
	import com.emirates.emiratesIn.net.Attention;
	import com.emirates.emiratesIn.net.events.AttentionEvent;
	import com.emirates.emiratesIn.view.IntroductionMediator;
	import com.emirates.emiratesIn.view.TestingMediator;
	import com.emirates.emiratesIn.view.TrainingMediator;
	import com.emirates.emiratesIn.view.components.IntroductionView;
	import com.emirates.emiratesIn.view.components.TestingView;
	import com.emirates.emiratesIn.view.components.TrainingView;

	import org.robotlegs.base.ContextEvent;
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
			commandMap.mapEvent( ContextEvent.STARTUP, StartupCommand, ContextEvent, true );
			
			// Events to commands
			commandMap.mapEvent(AttentionEvent.UPDATED, AttentionUpdatedCommand, AttentionEvent);
			
			// Models
			injector.mapSingleton(AttentionModel);
			injector.mapSingleton(ResultsModel);

			// Signals
			injector.mapSingleton(AttentionUpdatedSignal);
			injector.mapSingleton(NextTestSignal);
			injector.mapSingleton(NoTestsSignal);
			
			injector.mapSingleton(IntroductionStartSignal);
			injector.mapSingleton(IntroductionCompleteSignal);
			injector.mapSingleton(TrainingStartSignal);
			injector.mapSingleton(TrainingCompleteSignal);
			injector.mapSingleton(TestingStartSignal);
			injector.mapSingleton(TestingCompleteSignal);
			
			// Signals to commands
			signalCommandMap.mapSignalClass(IntroductionCompleteSignal, IntroductionCompleteCommand);
			signalCommandMap.mapSignalClass(TrainingCompleteSignal, TrainingCompleteCommand);
			signalCommandMap.mapSignalClass(TestingStartSignal, TestingStartCommand);
			signalCommandMap.mapSignalClass(TestingCompleteSignal, TestingCompleteCommand);

			// Views
			mediatorMap.mapView(IntroductionView, IntroductionMediator);
			mediatorMap.mapView(TestingView, TestingMediator);
			mediatorMap.mapView(TrainingView, TrainingMediator);

			contextView.addChild(new IntroductionView());
			contextView.addChild(new TestingView());
			contextView.addChild(new TrainingView());

			Attention.addEventListener(AttentionEvent.UPDATED, attentionUpdatedHandler);
			Attention.start();
			
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
		}

		private function attentionUpdatedHandler(event : AttentionEvent) : void
		{
			eventDispatcher.dispatchEvent(event);
		}
	}
}
