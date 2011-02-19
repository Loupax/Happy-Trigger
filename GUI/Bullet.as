package GUI 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Loupax
	 */
	public class Bullet extends FlxSprite
	{
		
		[Embed(source = '../../lib/img/bullet.png')]private var ImgHeart:Class;
		public function Bullet(X:int,Y:int) 
		{
			super(X, Y);
			loadGraphic(ImgHeart, true, false, 50, 50);
			addAnimation("idle", [0], 0);
			width = height *= 0.5;
			scale.x = scale.y = 0.5;
			canCollide = false;
		}
		
		override public function update():void 
		{
			
			play("idle");
			super.update();
		}
	}

}