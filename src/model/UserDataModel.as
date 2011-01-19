package model
{
	import model.vo.ReceivedDataVO;
	
	import org.robotlegs.mvcs.Actor;
	
	import signals.BalanceSet;
	import signals.ChangeState;
	import signals.IterationChange;
	import signals.StageSet;
	import signals.UserDataSet;
	
	import spark.components.mediaClasses.VolumeBar;
	
	public class UserDataModel extends Actor
	{
		[Inject]
		public var userDataSet:UserDataSet;
		[Inject]
		public var stageSet:StageSet;
		[Inject]
		public var changeState:ChangeState;
		[Inject]
		public var balanceSet:BalanceSet;
		[Inject]
		public var iterationChange:IterationChange;
		
		public var gameID:String = "12345";//TODO set the game ID somehow and store it externally
		
		private var _budget:Number;
		private var _iteration:int;
		
		private var _vo:ReceivedDataVO;
		private var _stage:int; /* -1 intro, 
									0 entering first round, 1 showing first round, 
									2 entering 2nd round, 3, showing 2nd round,
									4, entering 3rd round, 5, showing 3rd round,
									6 Final score screen
									7 Exit Slide Screen */

		public function get stage():int
		{
			return _stage;
		}

		public function updateBalance( n:Number ):void{
			
			var newBudget:Number = budget +n;
			budget = Math.round(newBudget*100)/100;
			
			//budget += n;
			//16.2
			
			
			//balanceSet.dispatch(budget);
			
		}
		
		
		public function set stage(value:int):void
		{
			_stage = value;
			stageSet.dispatch(_stage); 
		}

		public function get vo():ReceivedDataVO
		{
			return _vo;
		}

		public function set vo(value:ReceivedDataVO):void
		{
			_vo = value;
			changeState.dispatch(ChangeState.ENTER_SCREEN); 
			//dispatch after so the mediator is instantiated
			userDataSet.dispatch(_vo);
			
		}

		public function get budget():Number
		{
			return _budget;
		}

		public function set budget(value:Number):void
		{
			_budget = value;
			balanceSet.dispatch(_budget);
		}

		public function get iteration():int
		{
			return _iteration;
		}

		public function set iteration(value:int):void
		{
			_iteration = value;
			iterationChange.dispatch(_iteration);
		}


	}
}