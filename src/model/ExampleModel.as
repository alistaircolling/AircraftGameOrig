package model
{
	import org.robotlegs.mvcs.Actor;
	
	import signals.TextSetOnModel;
	
	public class ExampleModel extends Actor
	{
		[Inject]
		public var textSetOnModel:TextSetOnModel;
		
		private var _data:String;
		
		public function ExampleModel()
		{
			super();
		}

		public function get data():String
		{
			return _data;
		}

		public function set data(value:String):void
		{
			_data = value;
			//dispatch signal
			textSetOnModel.dispatch(_data);
		}

	}
}