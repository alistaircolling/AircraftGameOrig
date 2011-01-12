package controllers
{
	import model.SettingsModel;
	import model.vo.SettingsVO;
	import signals.SettingsUpdated;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class ServiceSetCommand extends SignalCommand
	{
		[Inject]
		public var settings:SettingsVO;
		
		override public function execute():void{
			//chain in the next command- generate display etc.
		}
		
		
	}
}