package services
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import model.UserDataModel;
	
	import org.robotlegs.mvcs.Actor;
	
	public class GameIDService extends Actor
	{
		[Inject]
		public var userModel:UserDataModel;
		
		private var _gameXML:XML;
		private var _gameID:Number;
		private var _gameFile:File;
		
		public function updateID( n:Number):void{
			
			
			//write the next game ID back
			var nodeString:String = "<currentGame>"+n.toString()+"</currentGame>";
			var newID:XML = new XML(nodeString);
			_gameXML.replace(0, newID);
			var outputString:String  = '<?xml version="1.0" encoding="utf-8"?>\n';
			outputString += _gameXML.toXMLString();
			outputString = outputString.replace(/\n/g, File.lineEnding);
			
			var directory:File = File.documentsDirectory;
			_gameFile = directory.resolvePath("Selex"+File.separator+"gameID.xml");
			var stream:FileStream = new FileStream();
			stream.open(_gameFile, FileMode.WRITE);
			stream.writeUTFBytes(nodeString);
			
		}
		
		
		public function requestID():void{
			
			var gameIDData:String = xmlFile("Selex"+File.separator+"gameID.xml");
			_gameXML = new XML(gameIDData);
			_gameID = Number(_gameXML.valueOf());
			_gameID ++;
			userModel.gameID = _gameID;
			
			updateID(_gameID);
			
		
		}
	
	private function xmlFile( path:String ):String{
		
		var directory:File = File.documentsDirectory;
		var _dataFile:File = directory.resolvePath(path);
		var stream:FileStream = new FileStream();
		stream.open(_dataFile, FileMode.READ);
		var retS:String = stream.readUTFBytes(stream.bytesAvailable);
		stream.close();
		return retS;
		
	}
	}
}