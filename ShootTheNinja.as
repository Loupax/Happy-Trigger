package  
{
	import org.flixel.FlxBitmapFont;
	import org.flixel.FlxBitmapText;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import targetPkg.Breakable;
	import targetPkg.Ninja;
	import targetPkg.NinjaKanji;
	import targetPkg.Obstacle;
	import org.flixel.FlxG;
	import targetPkg.ObstacleGraphic;
	import targetPkg.DeadNinja;
	import org.flixel.FlxU;
	import targetPkg.Stupid;
	/**
	 * ...
	 * @author Loupax
	 */
	public class ShootTheNinja extends ShootingMinigameState
	{
		
		private var speedFactor:int;
		private var howManyNinjas:uint;
		private var howManyHideouts:uint;
		//private var thisStateTime:int;
		private var hideouts:FlxGroup;
		private var ninja:Ninja;
		private var increment:Number=1;
		private var gameOverTimer:Number = increment;
		private var soundPlayed:Boolean = false;
		
		public static var ninjaScore:int;
		
		[Embed(source = '../lib/img/bush.png')]private var ImgBush:Class;
		
		[Embed(source = '../lib/snds/leaf.mp3')]private var SndLeaf:Class;
		
		public function ShootTheNinja(lives:int,difficulty:int,bgColor:uint) :void
		{
			FlxState.bgColor = bgColor;
			setDifficultyLevel(difficulty);
			super(howManyNinjas, thisStateTime, lives, difficulty);
			bulletsLeft = 3;
		}
		
		override public function create():void 
		{
			var stupidBackDrop:Stupid = new Stupid(FlxG.width / 2, FlxG.height / 2);
			stupidBackDrop.scale.x = stupidBackDrop.scale.y = 6;
			stupidBackDrop.width = stupidBackDrop.height *= stupidBackDrop.scale.x;
			add(stupidBackDrop);
			add(new NinjaKanji(stupidBackDrop.x, stupidBackDrop.y + stupidBackDrop.height / 4));
			
			//add(stupidBackDrop);
			FlxG.mouse.hide();
			super.create();			
			hideTheClock();
			spawnHideouts(howManyHideouts);
			add(new Crosshair());
			ninja = new Ninja( 50, 50, obstacles);
			ninja.speedFactor = speedFactor;
			spawnTarget(ninja);
			
			//instructions...
			instructions.x = Math.random() * FlxG.width;
			instructions.y = FlxG.height - 25;
			instructions.visible = true;
			instructions.color = 0xff000000;
			instructions.text = "The bushes are his strength! Shoot him while he is away!";
			
			//add(new FlxBitmapText(100, 20, null, "Left aligned, auto width, color=0xFF0000, font toggles on click"));
			//add(new FlxBitmapText(50, 100, null, "FLIXEL IS GREAT!"));
			//var font:FlxBitmapFont = new FlxBitmapFont(fontBlox,22,2,5,".01234567890:<>ABCDEFGHIJKLMNOPQRSTUVWXWZ");
			//var test:FlxBitmapText = new FlxBitmapText(100, 50,font,"This is just a text");
			//add(test);
					
		}
		
		override protected function damageTarget(bullet:Bullet, target:Breakable):void 
		{
			if(!target.isCovered){target.health--;
			if (target.health <= 0) {
				if(targetsArray.length>0)targetsArray.pop().kill();
				spawnDeadNinja(target.x,target.y);
				target.kill();
				//spawnGibs(bullet);
			targetsDestroyed++;}}
		}
		
		private function spawnDeadNinja(X:int, Y:int):void {
			var corpse:DeadNinja = new DeadNinja(X, Y);
			add(corpse);
		}
		
		override public function update():void 
		{
					
			displayBulletsLeft();
			if (ninja.ninjaLeft) loseLevel();
			if (bulletsLeft <= 0 && !ninja.dead) {
				if (gameOverTimer > 0) gameOverTimer -= FlxG.elapsed;
				if (gameOverTimer < 0) loseLevel();
			}
			if (ninja.dead && !ninja.ninjaLeft) { 
				if (gameOverTimer > 0) gameOverTimer -= FlxG.elapsed;
				if (gameOverTimer < 0) { ninjaScore++; winLevel(); } 
				}
				
			FlxU.overlap(ninja, obstacleGraphics, moveBushes);
			super.update();
		}
		
		private function moveBushes(ninja:Ninja, bush:ObstacleGraphic):void {
			if (ninja.velocity.x != 0 && ninja.velocity.y != 0) {
				bush.play("moving");
				if (!soundPlayed) {
					FlxG.play(SndLeaf);
					soundPlayed = true;
				}
			}
			else bush.play("idle");
			//soundPlayed = false;
		}
		
		private function spawnHideouts(howMany:int):void {
			var i:int;
			for (i = 0; i < howMany; i++) {
				var _obstacle:Obstacle = new Obstacle(Math.floor(Math.random() * FlxG.width-30)+15, Math.floor(Math.random() * FlxG.height-60)+30); 
				spawnObstacle(_obstacle);
				var _obstacleGraphic:ObstacleGraphic = new ObstacleGraphic(_obstacle.x - 30, _obstacle.y);
				_obstacleGraphic.loadGraphic(ImgBush,true);
				_obstacleGraphic.addAnimation("idle", [0]);
				_obstacleGraphic.addAnimation("moving", [0, 1,2], 5, false);
				_obstacleGraphic.scale.x=_obstacleGraphic.scale.y = 2;
				_obstacleGraphic.width = _obstacleGraphic.height *= 2;
				spawnObstacleGraphic(_obstacleGraphic);
				//hideouts.add(_obstacleGraphic);
				//FlxU.overlap(hideouts, hideouts, respawnBush);
				
			}
		}
		
		/*private function respawnBush(obstacleA:ObstacleGraphic, obstacleB:ObstacleGraphic):void {
			obstacleB.respawn
		}*/
		
		private function setDifficultyLevel(difficulty:int):void {
			bulletsLeft = 3;
			howManyHideouts = (difficulty + 2) * 2;
			if (howManyHideouts > 18) howManyHideouts = 18;
			speedFactor = (difficulty+0.5)/difficulty;
			thisStateTime = 10000;
		}
	}

}