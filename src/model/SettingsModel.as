package model
{
	import model.vo.SettingsVO;
	
	import org.robotlegs.mvcs.Actor;
	
	
	import signals.SettingsUpdated;
	
	public class SettingsModel extends Actor
	{
		[Inject]
		public var serviceSet:SettingsUpdated;
		[Inject]
		private var _settings:SettingsVO;
		
		private var _exampleSetting:String;
		
		
		public function set settings(__value:SettingsVO):void
		{
			_settings = __value;
			
			_exampleSetting = _settings.exampleValue;
			
			//dispatch the signals that informs model has been updated 
			serviceSet.dispatch(_settings);
			
		}
		
	
		public function get settings():SettingsVO
		{
			return _settings;
		}

		

	}
}