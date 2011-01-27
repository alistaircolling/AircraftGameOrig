﻿package services.socketUtils{	//import flash.display.Sprite;	import events.SocketEvent;		import flash.errors.*;	import flash.events.*;	import flash.net.Socket;
	public class CustomSocket extends Socket {		public var response:Array = new Array();		public var messageSender:IEventDispatcher = new EventDispatcher();		public const NEW_MSG:String = "new message";		public const CONNECTED:String = "connected";		public var responseMsg:String;		public function CustomSocket(host:String = null, port:uint = 0) {			super(host, port);			configureListeners();		}		private function configureListeners():void {			addEventListener(Event.CLOSE, closeHandler);			addEventListener(Event.CONNECT, connectHandler);			addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);			addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);			addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);		}		public function write(str:String):void {			trace("CustomSocket.write(" + str + ")");			try {				writeUTFBytes(str);				flush();			} catch (e:IOError) {				trace(e);			}		}		private function read():void {			var str:String = readUTFBytes(bytesAvailable);			responseMsg = str;			response[response.length] = str;			trace ("CustomSocket.read(" + response[response.length-1] + ")");			messageSender.dispatchEvent(new Event(this.NEW_MSG));		}		private function closeHandler(event:Event):void {			trace("CustomSocket.closeHandler(" + event + ")");			trace(response.toString());			var ev:SocketEvent = new SocketEvent("socket closed");			messageSender.dispatchEvent(ev);		}		private function connectHandler(event:Event):void {			trace("CustomSocket.connectHandler(" + event + ")");			messageSender.dispatchEvent(new Event(CONNECTED));		}		private function ioErrorHandler(event:IOErrorEvent):void {			trace("CustomSocket.ioErrorHandler(" + event + ")");			var ev:SocketEvent = new SocketEvent("io error");			messageSender.dispatchEvent(ev);		}		private function securityErrorHandler(event:SecurityErrorEvent):void {			trace("CustomSocket.securityErrorHandler(" + event + ")");			var ev:SocketEvent = new SocketEvent("security error");			messageSender.dispatchEvent(ev);		}		private function socketDataHandler(event:ProgressEvent):void {			trace("CustomSocket:socketDataHandler: " + event);			var ev:SocketEvent = new SocketEvent("socket data bytes available:"+bytesAvailable);			messageSender.dispatchEvent(ev);			read();		}	}}