package targetPkg 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import targetPkg.MeteorTail;
	/**
	 * ...
	 * @author Loupax
	 */
	public class Meteor extends Breakable
	{
		[Embed(source = '../../lib/img/meteor.png')] private var meteorImg:Class;
		public var thisMeteorTail:MeteorTail;
		private var flashingTimer:Number = 0.5;
		public var currentAnimation:String = new String("idle");
		public function Meteor(X:int,Y:int,hitPoints:int=6) 
		{
			super(X, Y);
			thisMeteorTail = new MeteorTail(X, Y);
			FlxG.state.add(thisMeteorTail);
			loadGraphic(meteorImg, true, false, 100, 100);
			addAnimation("idle", [0,3],8);
			addAnimation("flashing", [0, 1, 2,3], 20);
			health = hitPoints;
			healthTotal = hitPoints;
			
		}
		
		override public function update():void 
		{
			play(currentAnimation);
			if (currentAnimation == "flashing") {
				if (flashingTimer > 0) flashingTimer -= FlxG.elapsed;
				if (flashingTimer < 0) {
					currentAnimation = "idle";
					flashingTimer = 0.5;
				}
			}
			canCollide = false;
			angularAcceleration = 100;
			thisMeteorTail.scale.x = thisMeteorTail.scale.y = scale.x;
			//velocity.x = -(FlxG.width/30);
			//velocity.y = (FlxG.height / 30);
			
			super.update();
		}
		
		public function makeTailVisible():void {
			if(thisMeteorTail.alpha<0.8)
			thisMeteorTail.alpha += 0.01;
			if (thisMeteorTail.alpha >= 0.5) {
				if (this.color < 16711680)
				this.color += 65536;

			}
		}
		
	}

}