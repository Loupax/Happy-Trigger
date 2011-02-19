package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class Crosshair extends FlxSprite
	{
		[Embed(source = '../lib/img/crosshair.png')] private var ImgCrosshair:Class;
		public function Crosshair(X:int=0,Y:int=0) 
		{
			super(X, Y, ImgCrosshair)
			canCollide = false;
		}
		
		override public function update():void 
		{
			x = FlxG.mouse.x - 25;
			y = FlxG.mouse.y - 25;
			super.update();
		}
	}

}