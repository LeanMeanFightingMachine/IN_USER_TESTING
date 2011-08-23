package com.emirates.emiratesIn.model
{
	import com.emirates.emiratesIn.enum.Config;
	import com.emirates.emiratesIn.controller.signals.GotNextStateSignal;
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author Fraser Hobbs
	 */
	public class StateModel extends Actor
	{
		[Inject]
		public var nextStateSignal:GotNextStateSignal;
		
		private var _state:String;
		
		public function StateModel()
		{
		}
		
		public function next() : void
		{
			if(_state)
			{
				for (var i : int = 0; i < Config.STATES.length; i++)
				{
					if(Config.STATES[i] == _state)
					{
						if(i < Config.STATES.length - 1)
						{
							_state = Config.STATES[i + 1];
						}
						else
						{
							_state  = Config.STATES[0];
						}
						break;
					}
				}
			}
			else
			{
				_state = Config.STATES[0];
			}
			
			nextStateSignal.dispatch(_state);
		}
	}
}
