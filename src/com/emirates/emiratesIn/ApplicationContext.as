package com.emirates.emiratesIn
{
	import com.emirates.emiratesIn.controller.commands.TestInitialCommand;
	import com.emirates.emiratesIn.controller.signals.TestInitialSignal;
	import com.emirates.emiratesIn.controller.commands.AnswersCompleteCommand;
	import com.emirates.emiratesIn.controller.signals.AnswersCompleteSignal;
	import com.emirates.emiratesIn.service.DatabaseService;
	import com.emirates.emiratesIn.controller.commands.AttentionUpdateCommand;
	import com.emirates.emiratesIn.controller.commands.GotNextStateCommand;
	import com.emirates.emiratesIn.controller.commands.GotNextTestCommand;
	import com.emirates.emiratesIn.controller.commands.StartupCommand;
	import com.emirates.emiratesIn.controller.commands.StateCompleteCommand;
	import com.emirates.emiratesIn.controller.commands.TestCompleteCommand;
	import com.emirates.emiratesIn.controller.commands.TestHotspotCommand;
	import com.emirates.emiratesIn.controller.commands.TestRetryCommand;
	import com.emirates.emiratesIn.controller.commands.TestStartCommand;
	import com.emirates.emiratesIn.controller.commands.TestUpdateCommand;
	import com.emirates.emiratesIn.controller.signals.AttentionUpdateSignal;
	import com.emirates.emiratesIn.controller.signals.GotNextStateSignal;
	import com.emirates.emiratesIn.controller.signals.GotNextTestSignal;
	import com.emirates.emiratesIn.controller.signals.NoTestsSignal;
	import com.emirates.emiratesIn.controller.signals.StateCompleteSignal;
	import com.emirates.emiratesIn.controller.signals.TestCompleteSignal;
	import com.emirates.emiratesIn.controller.signals.TestFailSignal;
	import com.emirates.emiratesIn.controller.signals.TestHotspotSignal;
	import com.emirates.emiratesIn.controller.signals.TestRetrySignal;
	import com.emirates.emiratesIn.controller.signals.TestStartSignal;
	import com.emirates.emiratesIn.controller.signals.TestSuccessSignal;
	import com.emirates.emiratesIn.controller.signals.TestUpdateSignal;
	import com.emirates.emiratesIn.model.AttentionModel;
	import com.emirates.emiratesIn.model.ResultsModel;
	import com.emirates.emiratesIn.model.StateModel;
	import com.emirates.emiratesIn.model.TestModel;
	import com.emirates.emiratesIn.model.TestingModel;
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
			commandMap.mapEvent(AttentionEvent.UPDATED, AttentionUpdateCommand, AttentionEvent);
			
			// Models
			injector.mapSingleton(AttentionModel);
			injector.mapSingleton(ResultsModel);
			injector.mapSingleton(StateModel);
			injector.mapSingleton(TestingModel);
			injector.mapSingleton(TestModel);
			
			// Services
			injector.mapSingleton(DatabaseService);

			// Signals
			injector.mapSingleton(AttentionUpdateSignal);
			
			injector.mapSingleton(TestCompleteSignal);
			injector.mapSingleton(TestInitialSignal);
			injector.mapSingleton(GotNextTestSignal);
			injector.mapSingleton(NoTestsSignal);
			injector.mapSingleton(TestStartSignal);
			injector.mapSingleton(TestRetrySignal);
			injector.mapSingleton(TestUpdateSignal);
			injector.mapSingleton(TestSuccessSignal);
			injector.mapSingleton(TestFailSignal);
			injector.mapSingleton(TestHotspotSignal);
			injector.mapSingleton(GotNextStateSignal);
			injector.mapSingleton(StateCompleteSignal);
			injector.mapSingleton(AnswersCompleteSignal);
			
			// Signals to commands
			signalCommandMap.mapSignalClass(StateCompleteSignal, StateCompleteCommand);
			signalCommandMap.mapSignalClass(GotNextStateSignal, GotNextStateCommand);
			signalCommandMap.mapSignalClass(TestCompleteSignal, TestCompleteCommand);
			signalCommandMap.mapSignalClass(TestInitialSignal, TestInitialCommand);
			signalCommandMap.mapSignalClass(GotNextTestSignal, GotNextTestCommand);
			signalCommandMap.mapSignalClass(TestStartSignal, TestStartCommand);
			signalCommandMap.mapSignalClass(TestRetrySignal, TestRetryCommand);
			signalCommandMap.mapSignalClass(TestHotspotSignal, TestHotspotCommand);
			signalCommandMap.mapSignalClass(TestUpdateSignal, TestUpdateCommand);
			signalCommandMap.mapSignalClass(AnswersCompleteSignal, AnswersCompleteCommand);

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
