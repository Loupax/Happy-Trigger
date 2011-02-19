package targetPkg
{
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class Bottle extends Breakable
	{
		[Embed(source='../../lib/img/Bottle.png')]private var ImgBottle:Class;
		public function Bottle(X:int,Y:int) 
		{
			super(X, Y);
			loadGraphic(ImgBottle, true, false, 18, 49);
			addAnimation("idle", [0], 0, true);
			acceleration.y = 400;
			angle = Math.random() * 90;
			health = 1;
			collideBottom = false;
		}
		
		override public function update():void 
		{
			play("idle");
			if (health <= 0) kill();
			super.update();
		}
		
	}

}