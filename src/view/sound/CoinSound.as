package view.sound
{
	import flash.media.Sound;

	
		import flash.display.Sprite;
		import flash.media.Sound;
		import flash.media.SoundChannel;
		
		public class CoinSound extends Sprite
		{
			[Embed(source="../../../embed/coin.mp3")]
			public var soundClass:Class;
			
			public var smallSound:Sound;
			
			public function CoinSound()
			{
				smallSound = new soundClass() as Sound;
				
			}
			
			public function playCoin():void{
				smallSound.play();
			}
			
		}
}