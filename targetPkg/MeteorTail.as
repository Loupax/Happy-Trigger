package targetPkg 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Loupax
	 */
	public class MeteorTail extends FlxSprite
	{
		[Embed(source = '../../lib/img/FallingMeteor.png')] private var ImgFallingMeteor:Class;
		public function MeteorTail(X:int,Y:int) 
		{
			super(X, Y);
			alpha = 0;
			loadGraphic(ImgFallingMeteor, true);
			addAnimation("idle", [0, 1, 2], 6);
		}
		
		override public function update():void 
		{
			play("idle");
			super.update();
		}
		
	}

}