package controllers
{
	import model.SettingsModel;
	import model.vo.SettingsVO;
	import signals.SettingsXMLLoaded;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class StoreSettingsXMLCommand extends SignalCommand
	{
		[Inject]
		public var settingsModel:SettingsModel;
		[Inject]
		public var settings:SettingsVO;
		
			
		
		override public function execute():void{
			trace("store xml settings command");
			settingsModel.settings = settings;
		}
	}
}