package com.emirates.emiratesIn.view
{
	import com.emirates.emiratesIn.controller.signals.ShowHideOutputSignal;
	import com.emirates.emiratesIn.display.ui.debug.Debug;
	import com.emirates.emiratesIn.enum.Config;
	import com.emirates.emiratesIn.service.DatabaseService;
	import com.emirates.emiratesIn.view.components.OutputView;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Fraser Hobbs
	 */
	public class OutputMediator extends Mediator
	{
		[Inject]
		public var view:OutputView;
		
		[Inject]
		public var showOutputSignal : ShowHideOutputSignal;
		
		[Inject]
		public var databaseService : DatabaseService;
		
		public function OutputMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			showOutputSignal.add(showOutputHandler);
		}
		
		private function showOutputHandler():void
		{
			Debug.log("showOutputHandler");
			
			if(view.visible)
			{
				view.hide();
			}
			else
			{
				view.show();
				
				var data:Array = databaseService.getTypeComparisionData();
				
				var typeComparisonData:Object = new Object();
				var type:String;
				var level:int;
				var hold:int;
				var completedTime:int;
				
				for (var i : int = 0; i < data.length; i++)
				{
					completedTime = data[i]["completedTime"];
					
					if(completedTime)
					{
						type = data[i]["type"];
						level = data[i]["level"];
						hold = data[i]["hold"];
						
						if(!typeComparisonData[type])
						{
							typeComparisonData[type] = new Object();
							typeComparisonData[type]["level"] = new Array();
							typeComparisonData[type]["hold"] = new Array();
						}
						
						if(!typeComparisonData[type]["level"][level])
						{
							typeComparisonData[type]["level"][level] = new Object();
							typeComparisonData[type]["level"][level]["all"] = new Array();
						}
						
						if(!typeComparisonData[type]["hold"][hold])
						{
							typeComparisonData[type]["hold"][hold] = new Object();
							typeComparisonData[type]["hold"][hold]["all"] = new Array();
						}
						
						if(completedTime < 0)
						{
							typeComparisonData[type]["level"][level]["all"].push(Config.TESTING_DURATION * 1000);
							typeComparisonData[type]["hold"][hold]["all"].push(Config.TESTING_DURATION * 1000);
						}
						else
						{
							typeComparisonData[type]["level"][level]["all"].push(completedTime);
							typeComparisonData[type]["hold"][hold]["all"].push(completedTime);
						}
					}
				}
				
				var l:int;
				var n : int;
				var levelTotal:int;
			
				for (var t : String in typeComparisonData)
				{
					for (l = 0; l < typeComparisonData[t]["level"].length; l++)
					{
						levelTotal = 0;
						
						if(typeComparisonData[t]["level"][l])
						{
							for (n = 0; n < typeComparisonData[t]["level"][l]["all"].length; n++)
							{
								levelTotal += typeComparisonData[t]["level"][l]["all"][n];
							}
							
							typeComparisonData[t]["level"][l]["average"] = levelTotal / typeComparisonData[t]["level"][l]["all"].length;
						}
					}
					
					for (l = 0; l < typeComparisonData[t]["hold"].length; l++)
					{
						levelTotal = 0;
						
						if(typeComparisonData[t]["hold"][l])
						{
							for (n = 0; n < typeComparisonData[t]["hold"][l]["all"].length; n++)
							{
								levelTotal += typeComparisonData[t]["hold"][l]["all"][n];
							}
							
							typeComparisonData[t]["hold"][l]["average"] = levelTotal / typeComparisonData[t]["hold"][l]["all"].length;
						}
					}
				}
				
				view.update(typeComparisonData);
				
			}
		}
	}
}
