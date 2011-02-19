package GUI 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class Target extends FlxSprite
	{
		[Embed(source = '../../lib/img/Target.png')]private var ImgTarget:Class;
		public function Target(X:int,Y:int) 
		{
			super(X, Y);
			loadGraphic(ImgTarget, true, false, 50, 50);
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