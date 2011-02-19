package  
{
	import GUI.Boom;
	import GUI.BoundLine;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	import targetPkg.Breakable;
	import targetPkg.FlowerCore;
	import targetPkg.Meteor;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import org.flixel.FlxObject;
	import targetPkg.PlanetEarth;
	/**
	 * ...
	 * @author Loupax
	 */
	public class Armageddon extends ShootingMinigameState
	{
		[Embed(source = '../lib/snds/explosion2.mp3')] private var SndExplosion:Class;
		
		public static var armageddonScore:int;
		//private var thisStateTime:Number;
		
		private var planet:PlanetEarth;
		private var isSplashShown:Boolean = false;
		private var boundingBoxGroup:FlxGroup = new FlxGroup();
		
		
		public function Armageddon(lives:int,difficulty:int,bgColor:uint) 
		{
			FlxState.bgColor = bgColor;
			setDifficultyLevel(difficulty);
			super(0, thisStateTime, lives,difficulty);
			
		}
		
		override public function create():void 
		{
			trace(armageddonScore);
			planet = new PlanetEarth(0, FlxG.height - 100); 
			add(planet);
			
			//add(new FlowerCore(FlxG.width - 50, 150));
						
			super.create();
		
			spawnTarget(new Meteor((FlxG.width/2), FlxG.height/2, 20));
			
			FlxG.mouse.hide();
			add(new Crosshair());
			
			instructions.x = Math.random() * FlxG.width;
			instructions.y = FlxG.height - 25;
			instructions.visible = true;
			instructions.color = 0xffffffff;
			instructions.text = "Nukes won't help you here... Mow it down!";
		}
		
		override public function update():void 
		{
			
			if(timeOfLevel>10 && timeOfLevel<15)
			planet.scale.x = planet.scale.y += 0.01;
			
			if (timeOfLevel >= 5 && timeOfLevel < 10) 
			planet.scale.x = planet.scale.y += 0.02;
			
			if (timeOfLevel > 1 && timeOfLevel <= 5)
			planet.scale.x = planet.scale.y += 0.03;
			
			if (timeOfLevel > 0 && timeOfLevel<= 1 && targets.countLiving()!=0) {
				if (isSplashShown == false)
				{
					add(new Boom(FlxG.width / 2, FlxG.height / 2));
					FlxG.quake.start(0.08, 1);
				}
				isSplashShown = true;
			}
			
			if (timeOfLevel <= 0.5 && targets.countLiving() != 0)
			loseLevel();
			
			if (timeOfLevel <= 0.5 && targets.countLiving() == 0)
			{armageddonScore++; winLevel(); }
			
			if (FlxG.keys.R) FlxG.state = new NextLevelChooser();
			if (planet.scale.x > 8)
			{
				var i:int;
				for (i = 0; i < targets.members.length; i++) {
					if (targets.members[i].dead == false)
					targets.members[i].makeTailVisible();
					if (targets.members[i].dead == true)
					targets.members[i].thisMeteorTail.kill();
				}
				
			}
			
			super.update();
			//targetsCounter.alpha = 0;
						
		}
		
		
				
		override protected function damageTarget(bullet:Bullet, target:Breakable):void 
		{
			if(target.isCovered==false&&FlxG.mouse.justReleased())
			(target as Meteor).health--;
			(target as Meteor).currentAnimation = "flashing";
			trace(target.health);
			
			if (target.health <=0) {
				if(targetsArray.length>0)targetsArray.pop().kill();
				target.kill();
				FlxG.play(SndExplosion);
				spawnGibs(target);
				if (target.healthTotal > 1) {
					FlxG.quake.start(0.05, 0.2);
					var meteorchild1:Meteor = new Meteor(target.x+Math.ceil(Math.random()*target.width), target.y+Math.ceil(Math.random()*target.height), target.healthTotal / 4); 
					var meteorchild2:Meteor = new Meteor(target.x-Math.ceil(Math.random()*target.width), target.y-Math.ceil(Math.random()*target.height), target.healthTotal / 4);
					
					meteorchild1.scale.x = meteorchild1.scale.y = meteorchild2.scale.x = meteorchild2.scale.y = target.scale.x * 0.5;
					meteorchild1.height = meteorchild1.width = meteorchild2.height = meteorchild2.width *= (target.scale.x);
					
					/*meteorchild1.acceleration.y = 3000;
					meteorchild2.acceleration.y = -3000;
					//meteorchild1.acceleration.x = meteorchild2.acceleration.x = -3000;*/
					
					spawnTarget(meteorchild1);
					spawnTarget(meteorchild2);					
				}
				
				targetsDestroyed++;
			}
			
		}
		
		override protected function createEmitter():FlxEmitter 
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.delay = 5;
			emitter.gravity = 0;
			emitter.maxRotation = 0;
			emitter.setXSpeed(-500, 500);
			emitter.setYSpeed(-500, 500);
			var particles: int = 10;
			for(var i: int = 0; i < particles; i++)
			{
				var particle:FlxSprite = new FlxSprite();
				particle.createGraphic(2, 2, 0xFFFFFFFF);
				particle.exists = false;
				particle.canCollide = false;
				emitter.add(particle);
			}
			emitter.start();
			add(emitter);
			return emitter;
		}
		
		private function setDifficultyLevel(difficulty:int):void {
			if (difficulty == 1) thisStateTime = 12;
			if (difficulty == 2) thisStateTime = 11;
			if (difficulty == 3) thisStateTime = 10;
			if (difficulty == 4) thisStateTime = 9;
			if (difficulty == 5) thisStateTime = 8;
			if (difficulty == 6) thisStateTime = 7;
			if (difficulty > 6) thisStateTime = 7;
			
		}
		
	}

}