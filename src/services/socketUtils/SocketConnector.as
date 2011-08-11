package services.socketUtils
{

import flash.display.Sprite;
import flash.events.*;

import mx.controls.Alert;

import utils.CustomEvent;

	public class SocketConnector extends Sprite
	{
		private var ip:String;
		private var port:Number;
		public const DATA_RECEIVED:String = "dataReceived";
		public const CONNECTED:String = "connected";
		public var networkConnection:CustomSocket;
		
		
		public function SocketConnector(ipAddress:String, p:Number)
		{
			ip = ipAddress;
			port = p;
			createConnection();
			
		}
		public function send(s:String):void
		{
			networkConnection.write(s);
		}
		
		public function connect():void{
			
			//networkConnection.connectIt();
		}
		
		
		public function createConnection():void
		{
			//create socket connection
			networkConnection = new CustomSocket(ip, port);
			//add listener for data
			networkConnection.messageSender.addEventListener(networkConnection.NEW_MSG, myListener);
			networkConnection.messageSender.addEventListener(networkConnection.CONNECTED, connected);
			networkConnection.messageSender.addEventListener(CustomEvent.SOCKET_CONNECT_ERROR, socketError);
			networkConnection.messageSender.addEventListener(CustomEvent.SECURITY_ERROR, socketError);
			
		}
		
		private function socketError( c:CustomEvent ):void{
			
			var e:CustomEvent = c.clone() as CustomEvent;
			dispatchEvent(e);
			
		}
		private function connected(e:Event):void
		{
			trace("connected, dispatching event");
			dispatchEvent(new Event(CONNECTED));
		}
		private function myListener(e:Event):void
		{
			trace("event dispatched");
			var c:CustomEvent = new CustomEvent(DATA_RECEIVED, false, false,networkConnection.responseMsg);
			c.responseStr = networkConnection.responseMsg;
			dispatchEvent(c);
			
		}

	}
}


