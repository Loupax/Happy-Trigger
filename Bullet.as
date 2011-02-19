package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class Bullet extends FlxSprite
	{
		[Embed(source = '../lib/img/AntimatterTiles3.png')] private var ImgBullet:Class;
		public function Bullet(X:int,Y:int) 
		{
			super(X - (25), Y - (25));
			scale.x = scale.y = 0.5;
			height = width *= scale.x;
			loadGraphic(ImgBullet, true);
			addAnimation("idle", [0, 1, 2, 3, 4], 10, true);
			canCollide = false;
			
		}
		
		override public function update():void 
		{
			
			//FlxG.showBounds=true;
			play("idle");
			if((alpha-=0.2)<0)
				kill();
			super.update();
			
		}
		
	}

}