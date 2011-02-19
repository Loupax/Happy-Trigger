package GUI 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class Clock extends FlxSprite
	{
		private var _timeTotal:int;
		private var _timeLeft:int;
		
		[Embed(source = '../../lib/img/ClockBody2.png')] private var ImgClockBody:Class;
		public function Clock(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(ImgClockBody, true, false);
			addAnimation("idle", [0, 1], 4);
			//var clockHand:ClockHand = new ClockHand(width / 2, height / 2);
			
		}
		
		override public function update():void 
		{
			play("idle");
			super.update();
		}
		
	}

}