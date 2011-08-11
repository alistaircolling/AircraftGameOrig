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
			stream.close();
			handleServiceResult(_data);
			
		}
		
		
		public function writeToXML():void{
			
			var outputString:String  = '<?xml version="1.0" encoding="utf-8"?>\n';
			outputString += _xml.toXMLString();
			outputString = outputString.replace(/\n/g, File.lineEnding);
			
			var stream:FileStream = new FileStream();
			stream.open(_dataFile, FileMode.WRITE);
			stream.writeUTFBytes(outputString);
		}
		
		//used to update the winners list while the user enters their details
		public function updateWinnersListTemp( vo:UserVO, pos:uint, addToList:Boolean ):void{
			//added to avoid error
			trace("update:"+vo.label+"  pos:"+pos);
			if (addToList){
				pos
			}
			//if add to list
			//first time, remove the item, the
			var lbVO:LeaderBoardVO = lbModel.vo;
			lbVO.winners.addItemAt(vo, pos);
			var remInd:uint = pos+1;//replace the existing one
			if( addToList ) {
				remInd = lbVO.winners.length-1;	
			} 
			lbVO.winners.removeItemAt(remInd);
			//update the xml
			var nodeString:String = '<user name="'+vo.label+'" score="'+vo.score.toString()+'" />';
			var winner:XML =  new XML(nodeString);
			var nodeBefore:XML = _xml.children()[pos] as XML;
			_xml.insertChildBefore(nodeBefore, winner);
			//remove last child
			delete _xml.children()[remInd];
			//set on model to dispatch event
			lbModel.vo = lbVO;
			
		}
		
		//write the new winner to the model and also to the xml
		public function writeNewWinner():void{
			
			//TODO
		}
		
		private function handleServiceResult(s:String):void{
			trace("leader board data received");
			statusUpdate.dispatch("leader board xml loaded");
			_xml = new XML(s);//event.result as XML;
			var winnersList:XMLList = _xml.user;
			var vo:LeaderBoardVO = new LeaderBoardVO();
			var winners:Array = [];
			for(var i:uint = 0; i< winnersList.length(); i++){
				var user:XML = winnersList[i];
				var userVO:UserVO = new UserVO();
				userVO.label = user.@name;
				userVO.score = Number(user.@score);
				userVO.highlight = false;
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
			lbModel.vo = lBVO;
			
		}
	}
}