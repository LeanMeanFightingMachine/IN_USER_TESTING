package com.emirates.emiratesIn.controller.commands
{
	import com.emirates.emiratesIn.model.ResultsModel;
	import com.emirates.emiratesIn.service.DatabaseService;
	import com.emirates.emiratesIn.vo.ResultQualativeAnswerVO;

	import org.robotlegs.mvcs.SignalCommand;

	/**
	 * @author Fraser Hobbs
	 */
	public class AnswersCompleteCommand extends SignalCommand
	{
		[Inject]
		public var answers:Vector.<ResultQualativeAnswerVO>;
		
		[Inject]
		public var resultsModel:ResultsModel;
		
		[Inject]
		public var databaseService:DatabaseService;
		
		override public function execute() : void
		{
			resultsModel.answers = answers;
			
			for (var i : int = 0; i < answers.length; i++)
			{
				databaseService.insertAnswer(answers[i].questionID, answers[i].answerID);
			}
		}
	}
}
