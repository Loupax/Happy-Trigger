package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import targetPkg.Breakable;
	import targetPkg.DeadFly;
	import targetPkg.Fly;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class ZappingFlies extends ShootingMinigameState
	{
		public static var fliesScore:int;
		private var howManyFlies:int;
		//private var thisStateTime:int;
		private var bgSprite:FlxSprite;
		[Embed(source = '../lib/img/Fallaserna.png')] private var ImgBg:Class;
		[Embed(source='../lib/snds/hit.mp3')] private var hitSnd:Class;
		
		public function ZappingFlies(lives:int,difficulty:int,bgColor:uint) 
		{
			FlxState.bgColor = bgColor;
			setDifficultyLevel(difficulty);
			super(howManyFlies, thisStateTime, lives,difficulty);
		}
		
		override public function create():void 
		{
						
			bgSprite = new FlxSprite(0, 0, ImgBg);
			bgSprite.canCollide = false;
			add(bgSprite);
			super.create();
			targets.destroy();
			targets = new FlxGroup();
			add(targets);
			spawnFlies();
			FlxG.mouse.hide();
			add(new Crosshair());
			
			instructions.x = Math.random() * FlxG.width;
			instructions.y = FlxG.height - 25;
			instructions.visible = true;
			instructions.color = 0xff000000;
			instructions.text = "Eff-ing flies...";
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		private function spawnFlies():void {
			var i:int;
			for (i = 0; i < howManyFlies; i++)
			{
				spawnTarget(new Fly(Math.floor(Math.random() * (1 + FlxG.width - 60)), Math.floor(Math.random() * (1 + FlxG.height - 60))));
			}
			
		}
		
		override protected function shoot():void 
		{
			var bullet:Bullet = new Bullet(FlxG.mouse.screenX, FlxG.mouse.screenY); 
			bullets.add(bullet);
			FlxG.play(hitSnd);
			FlxG.flash.start(0xffffffff, 0.1);
			
		}
		
		override protected function winLevel():void 
		{
			ZappingFlies.fliesScore++;
			super.winLevel();
		}
		
		override protected function damageTarget(bullet:Bullet, target:Breakable):void 
		{
			
				
				target.health--;
			if (target.health <= 0) {
				if(targetsArray.length>0)targetsArray.pop().kill();
				spawnDeadFly(target.x,target.y);
				target.kill();
				//spawnGibs(bullet);
				targetsDestroyed++;
			}
		}
		
		private function spawnDeadFly(X:int,Y:int):void {
			var corpse:FlxSprite = new DeadFly(X, Y);
			add(corpse);
		}
		
		private function setDifficultyLevel(difficulty:int):void {
			howManyFlies = difficulty;
			if (difficulty <= 4) thisStateTime = difficulty + 3;
			else
			thisStateTime = (difficulty/2)+1 ;
		}
		
	}

}