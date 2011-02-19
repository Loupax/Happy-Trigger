package targetPkg 
{
	import flash.geom.Point;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	import com.loupax.random.Shuffle;
	/**
	 * ...
	 * @author Loupax
	 */
	public class Ninja extends Breakable
	{
		public var speedFactor:int = 1;
		private var whereFrom:int;
		private var ninjaPath:FlxGroup;
		private const initTime:Number=1.5
		private var hideTimer:Number = initTime;
		private var currentHidingPlace:int = 0;
		public var escaped:Boolean = false;
		private var canJump:Boolean = true;
		private var firstLoop:Boolean = true;
		private var dummyArray:Array;
		private var kicked:Boolean = false;
		public var ninjaLeft:Boolean = false;
		
		[Embed(source = '../../lib/img/ninja2.png')]private var ImgNinja:Class;
		[Embed(source = '../../lib/snds/dash.mp3')]private var SndDash:Class;
		[Embed(source = '../../lib/snds/xplode.mp3')] private var SndXplode:Class;
		
		public function Ninja(X:int , Y:int ,ninjaHideouts:FlxGroup) 
		{
			super(X, Y);
			loadGraphic(ImgNinja,true,false,20,20);
			addAnimation("dash", [0]);
			addAnimation("disappear", [1, 2, 3, 4, 5], 5, false);
			canCollide = false;
			whereFrom=decideFromWhereToSpawn();
			ninjaPath = ninjaHideouts;
			spawnFrom(whereFrom);
			scale.x = scale.y = 2;
			//maxVelocity.x=maxVelocity.y = 700;
			
		}
		
		override public function update():void 
		{
			var animation:String = new String();
			if (currentHidingPlace < ninjaPath.members.length) animation = "dash";
			if (escaped) animation = "disappear";
			//if (escaped) escapeTheLevel();
			if (animation == "disappear") FlxG.play(SndXplode);
			if (finished && animation == "disappear") { ninjaLeft = true; kill(); }
			play(animation);
			
			
			if (!escaped) {
				if (!onScreen()&&kicked==false) {
					FlxG.play(SndDash);
					jumpTowards(ninjaPath.members[currentHidingPlace].x, ninjaPath.members[currentHidingPlace++].y);
					kicked = true;
			}
			
			if (!targetIsReached) {
				if (hideCountDown()) {
					if (currentHidingPlace < ninjaPath.members.length) {
						FlxG.play(SndDash);
						jumpTowards(ninjaPath.members[currentHidingPlace].x, ninjaPath.members[currentHidingPlace++].y)} else
						escapeTheLevel();
				}
			}
			
			}
			/*if (FlxG.keys.LEFT) x--;
			if (FlxG.keys.RIGHT) x++;
			if (FlxG.keys.UP) y--;
			if (FlxG.keys.DOWN) y++;*/
			
			super.update();
			
		}
		
		private function escapeTheLevel():void {
			escaped = true;
			play("disappear");
			//if(finished) FlxState.state = new NextLevelChooser
			trace(finished);
			if(finished)kill();
			
		}
		
				
						
		public function resetTimer():void
		{
			hideTimer = Math.ceil(Math.random() * 3);
			//hideTimer = initTime;
		}
		
		private function hideCountDown():Boolean {
			if (hideTimer > 0) { hideTimer -= FlxG.elapsed; return false; }
			else { resetTimer(); return true; }
		}
		
		private function decideFromWhereToSpawn():int {
			return Math.ceil(Math.random() * 8);
		}
		
		/**
		 * Makes the sprite moving towards there(point) in a straight line
		 * When it is close enough to the point, it returns true
		 * @param	there
		 * @return  reachedThere
		 */
		private function jumpTowards(X:int,Y:int):Boolean{
			var distance:Number = Math.sqrt((X - x) ^ 2 +(Y - y) ^ 2);
			if (X > x) scale.x = +2;
			if (X < x) scale.x = -2;
			velocity.x = (X - x) * speedFactor;
			velocity.y = (Y - y) * speedFactor;
			if (distance <= width) return true else return false;
			
		}
		
		private function spawnFrom(location:int):int {
			switch(location) {
				case 1:
				{
					//Spawnarisou apo NW
					x = y = 0 - (width)*4;
					return location;
				}
				
				case 2:
				{
					//Spawnarisou apo N
					x = (FlxG.width / 2);
					y = 0 - (height)*4;
					return location;
				}
				
				case 3:
				{
					//Spawn from NE
					x = (FlxG.width);
					y = 0 - height*4;
					return location;
				}
				
				case 4:
				{
					//spawn from E
					x = FlxG.width+(width*4);
					y = FlxG.height / 2;
					return location;
				}
				
				case 5:
				{
					//spawn from SE
					x = FlxG.width +(width*4);
					y = FlxG.height;
					return location;
				}
				
				case 6:
				{
					//spawn from S
					x = FlxG.width / 2;
					y = FlxG.height + (height)*4;
					return location;
				}
				
				case 7:
				{
					
					//spawn from SW
					x = 0 - width*4;
					y = FlxG.height;
					return location;
				}
				
				case 8:
				{
					//spawn from W
					x = 0 - width*4;
					y = FlxG.height / 2;
					return location;
				}
			}
			return location;
		}
	}

}