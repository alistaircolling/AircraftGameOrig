
package view.mediators
{
	import org.robotlegs.mvcs.Mediator;
	
	import signals.ChangeState;
	import signals.MusicVolumeSet;
	
	import view.audio.BackgroundMusic;
	
	public class BackgroundMusicMediator extends Mediator
	{
	
		[Inject]
		public var backgroundMusic:BackgroundMusic;
		[Inject]
		public var changeState:ChangeState;
		[Inject]
		public var musicVolSet:MusicVolumeSet;
		
		override public function onRegister():void{
			
			changeState.add(onStateChanged);
			musicVolSet.add(onMusicVolumeSet);
			
		}
		
		private function onStateChanged( s:String):void{
			//always set to 20 (is triggered when anim completes)
				onMusicVolumeSet(20);
		
		}
		
		private function onMusicVolumeSet( n:uint):void{
			
			backgroundMusic.setVolume(n);
		}
	}
}