package controllers
{
	import model.UserDataModel;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class UpdateBalanceCommand extends SignalCommand
	{
		[Inject]
		public var userDataModel:UserDataModel;
		[Inject]
		public var balanceChange:Number;
		
		override public function execute():void{
			
			userDataModel.updateBalance(balanceChange);
			
		}
	}
}