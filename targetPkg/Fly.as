package targetPkg 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class Fly extends Breakable
	{
		private var heading:int;
		
		[Embed(source = '../../lib/img/FlyAnimation.png')]private var ImgFly:Class;
		public function Fly(X:int,Y:int) 
		{
			super(X, Y);
			movable = true;
			loadGraphic(ImgFly, true, false, 100, 100);
			addAnimation("bzzz", [0,1,2], 10);
			width = height = 30;
			scale.x = scale.y = 0.3;
			offset.y = offset.x = 30;
			maxThrust = 100;
			heading = Math.floor(Math.random() * 360);
			angle = heading;
			canCollide = true;
			
		}
		
		override public function update():void 
		{
			play("bzzz");
			super.update();
			if(!this.onScreen()) { 
				reset(50, 50);
			}
			//if (x+width > FlxG.width - 38) x = FlxG.width - 38;
		}
		
		override protected function decideDirection():void 
		{
			
			angle += Math.floor(Math.random()*4);
			thrust = -100;
		}
		
		
	}

}