package targetPkg
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class Breakable extends ShootingTarget
	{
		protected var direction:int;
		public var isForbiddenTarget:Boolean = false;
		public var movable:Boolean=false;
		protected const decisionInterval:Number = 0.2;
		public var isCovered:Boolean = false;
		private var decisionTimer:Number = decisionInterval;
		public var targetIsReached:Boolean = false;
		public var healthTotal:int;
		public function Breakable(X:int,Y:int) 
		{
			health = 1; //default health
			healthTotal = health;
			super(X, Y);
			
		}
		
		override public function update():void 
		{
			//if (health <= 0) kill();
			
			if (movable) decideDirection();
			
			super.update();
			
		}
		
		protected function decideDirection():void {
			if (decisionTimer > 0) decisionTimer -= FlxG.elapsed;
			if (decisionTimer < 0) {
				direction= Math.floor(Math.random() * 4);
				wanderAround();
				decisionTimer = decisionInterval;
				}
				
		}
		protected function wanderAround():void {
			
			if (direction == 0) velocity.x = -200;
			if (direction == 1) velocity.x = 200;
			if (direction == 2) velocity.y = -200;
			if (direction == 3) velocity.y = 200;				
			
		}
		
	}

}