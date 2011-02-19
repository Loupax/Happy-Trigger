package GUI 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Loupax
	 */
	public class Boom extends FlxSprite
	{
		[Embed(source = '../../lib/img/KaPow.png')] private var KaPowImg:Class;
		public var currentAnimation:String = new String("idle");
		public function Boom(X:int,Y:int) 
		{
			super(X, Y);
			loadGraphic(KaPowImg, true);
			addAnimation("idle", [0, 1], 2);
			addAnimation("static", [0]);
			scale.x = scale.y = 5;
		}
		
		override public function update():void 
		{
			play(currentAnimation);
			super.update();
		}
	}

}