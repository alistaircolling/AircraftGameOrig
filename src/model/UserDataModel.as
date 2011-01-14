package model
{
	import model.vo.InputDataVO;
	
	import org.robotlegs.mvcs.Actor;
	
	import signals.BalanceSet;
	import signals.ChangeState;
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

		
		private var _vo:InputDataVO;
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
			
			vo.budget += n;
			balanceSet.dispatch(vo.budget);
			
		}
		
		
		public function set stage(value:int):void
		{
			_stage = value;
			stageSet.dispatch(_stage); 
		}

		public function get vo():InputDataVO
		{
			return _vo;
		}

		public function set vo(value:InputDataVO):void
		{
			_vo = value;
			changeState.dispatch(ChangeState.ENTER_SCREEN); 
			//dispatch after so the mediator is instantiated
			userDataSet.dispatch(_vo);
			
		}

	}
}