package services
{
	
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import model.LeaderBoardModel;
	import model.vo.ErrorVO;
	import model.vo.LeaderBoardVO;
	import model.vo.UserVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.http.HTTPService;
	
	import org.robotlegs.mvcs.Actor;
	
	import signals.ErrorReceived;
	import signals.StatusUpdate;
	
	public class LeaderBoardService extends Actor
	{
		[Inject]
		public var lbModel:LeaderBoardModel;
		[Inject]
		public var errorReceived:ErrorReceived;
		[Inject]
		public var statusUpdate:StatusUpdate;
		
		private var _xmlFile:String = "data/winners.xml";
		private var _data:String;
		private var _xml:XML;
		private var _dataFile:File;
		
		public function requestData():void
		{
			//todo swap out to use flash vars instead
			//loads xml
			
			var directory:File = File.documentsDirectory;
			_dataFile = directory.resolvePath("Selex"+File.separator+"winners.xml");
			statusUpdate.dispatch("loading leaderboard from:"+_dataFile.url);
			var stream:FileStream = new FileStream();
			stream.open(_dataFile, FileMode.READ);
			_data = stream.readUTFBytes(stream.bytesAvailable);
			//statusUpdate.dispatch("data read yet?:"+_data);
			stream.close();
			//statusUpdate.dispatch("closed stream: data read yet?:"+_data);
			
			
			
			handleServiceResult(_data);
			/*
			var service:HTTPService = new HTTPService();
			var responder:mx.rpc.Responder = new Responder(handleServiceResult, handleServiceFault);
			var token:AsyncToken;
			service.resultFormat = "e4x";
			service.url = _xmlFile;
			token = service.send();
			token.addResponder(responder);*/
		}
		
	
		public function writeToXML( vo:UserVO, pos:uint ):void{
			var newWinners:XML = new XML();
			var nodeString:String = '<user name="'+vo.label+'" score="'+vo.score.toString()+'" />';
			var winner:XML =  new XML(nodeString);
			var nodeBefore:XML = _xml.children()[pos] as XML;
			 //_xml.replace(position, winner);
			_xml.insertChildBefore(nodeBefore, winner);
			//remove last child
			delete _xml.children()[10];
			
			var outputString:String  = '<?xml version="1.0" encoding="utf-8"?>\n';
			outputString += _xml.toXMLString();
			outputString = outputString.replace(/\n/g, File.lineEnding);
			
			var stream:FileStream = new FileStream();
			stream.open(_dataFile, FileMode.WRITE);
			stream.writeUTFBytes(outputString);
		}
		
		
		
		private function handleServiceResult(s:String):void{
			trace("leader board data received");
			statusUpdate.dispatch("leader board xml loaded");
			_xml = new XML(s);//event.result as XML;
			var winnersList:XMLList = _xml.user;
			var vo:LeaderBoardVO = new LeaderBoardVO();
			var winners:Array = [];
			//TODO add params here
			for(var i:uint = 0; i< winnersList.length(); i++){
				var user:XML = winnersList[i];
				var userVO:UserVO = new UserVO();
				userVO.label = user.@name;
				userVO.score = Number(user.@score);
				winners[i] = userVO;
			}
			vo.winners = new ArrayCollection(winners);
			
			//set the vo on the model
			lbModel.vo = vo;
			
		}
		
		private function handleServiceFault(event:Object):void{
			trace("xml error in loading, dispatching error signal");
			var vo:ErrorVO = new ErrorVO();
			vo.title = "XML Load Error";
			vo.msg = "There has been an error loading the leader board, please click OK to attempt load again";
			vo.fn = "reloadLeaderBoard";
			errorReceived.dispatch(vo);
		}
		
		//returns the position on the leaderboard of the user, -1 means they are not on the board
		public function returnWinnersPosition( vo:UserVO ):int{
			
			var retI:int = -1;
			//todo calculate position on the leaderboard
			return retI;
		}
		
		public function setNewWinner( vo:UserVO ):void{
			
			//find out where the new user should be placed
			var insert:int = returnWinnersPosition(vo);
			var lBVO:LeaderBoardVO = lbModel.vo;
			//lBVO.winners.splice( insert, 1, vo );
			lbModel.vo = lBVO;
			
		}
	}
}