package GUI 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class ClockHand extends FlxSprite
	{
		
		[Embed(source = '../../lib/img/ClockHand.png')] private var ImgHand:Class;
		public function ClockHand(X:int,Y:int) 
		{
			super(X, Y, ImgHand);
			
		}
				
		override public function update():void 
		{
			super.update();
		}
		
	}

}