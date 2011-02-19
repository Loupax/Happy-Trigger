package targetPkg 
{
	import org.flixel.FlxU;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class FlowerPetal extends Breakable
	{
		private var offsetPoint:FlxPoint = new FlxPoint();
		[Embed(source = '../../lib/img/Petal2.png')] private var ImgPetal:Class;
		public function FlowerPetal(X:int, Y:int, Angle:Number) 
		{
			
			super(X, Y);
			
			angle = Angle;
			
			loadGraphic(ImgPetal);
			
			addAnimation("idle", [0]);
		}
		
		override public function update():void 
		{
			play("idle");
			super.update();
		}
		
	}

}