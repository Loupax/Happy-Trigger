package  
{
	import Bullet;
	import com.loupax.HUD.HUDCounter;
	import GUI.Clock;
	import GUI.ClockHand;
	import GUI.Heart;
	import GUI.Target;
	import org.flixel.FlxText;
	import org.flixel.FlxSprite;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import targetPkg.Breakable;
	import org.flixel.FlxU;
	import org.flixel.FlxTilemap;
	import targetPkg.ExtraLife;
	import targetPkg.Obstacle;
	import targetPkg.ObstacleGraphic;
	
	import net.pixelpracht.tmx.TmxMap;
	import net.pixelpracht.tmx.TmxObject;
	import net.pixelpracht.tmx.TmxObjectGroup;
	
	//import flash.ui.Mouse;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class ShootingMinigameState extends FlxState
	{
		protected var timeOfLevel:Number;
		private var targetsRequired:int;
		private var currentLives:int;
		protected var currentDifficultyLevel:int;
		protected var targetsDestroyed:int = 0;
		
		private const initialHeartY:int = 10;
		private const initialHeartX:int = 50;
		private const initialTargetX:int = 8;
		private const initialTargetY:int = 10;
		private const initialBulletX:int = 8;
		private const initialBulletY:int = FlxG.height - 50;
		
		
		private var targetsLeftTxt:FlxText;
		private var timeLeftTxt:FlxText;
		private var livesLeftTxt:FlxText;
		
		protected var livesArray:Array = new Array();
		protected var targetsArray:Array = new Array();
		protected var bulletsArray:Array = new Array();
		private var totalTime:Number;
		
		private var clock:Clock;
		private var clockHand:ClockHand;
		
		protected var bullets:FlxGroup;
		protected var targets:FlxGroup;
		protected var forbiddenTargets:FlxGroup;
		protected var obstacles:FlxGroup;
		protected var obstacleGraphics:FlxGroup
		protected var bulletsLeft:int = 1000000;//int.MAX_VALUE;
		
		private var dontDoThis:Boolean = false;
		private var coverage:Boolean = false;
		
		protected var livesCounter:HUDCounter;
		protected var targetsCounter:HUDCounter;
		protected var bulletsCounter:HUDCounter;
		
		protected var wall:FlxTilemap;
		
		public static var bulletsFired:int;
		public static var bulletsHit:int;
		protected var thisStateTime:Number;
		protected static var musicIsFadedOut:Boolean;
		public static var globalScore:int;
		protected static var bonusSpawnInterval:Number = 30;
		protected static var bonusSpawnTimer:Number = bonusSpawnInterval;
		protected var instructions:FlxText;
		
		protected var endGameInterval:Number = 1;
		protected var endGameTimer:Number = endGameInterval;
		//private var timeToBonus:FlxText;
		
		[Embed(source = '../lib/snds/emptyGun.mp3')]protected var EmptyGunSnd:Class;
		
		
		[Embed(source = '../lib/tilemaps/map01.tmx', mimeType = 'application/octet-stream')]private var embededTmx:Class;
		[Embed(source = '../lib/tilemaps/tiles.png')] private var ImgTiles:Class;
		[Embed(source = '../lib/snds/asplode.mp3')]private var shotSound:Class;
		private static var extraLife:ExtraLife;
		
		public function ShootingMinigameState(targets:int,time:Number,lives:int,difficultyLevel:int) 
		{
			targetsRequired = targets;
			timeOfLevel = time;
			totalTime = time;
			currentLives = lives;
			currentDifficultyLevel = difficultyLevel;
		}
		
		override public function create():void 
		{
			loadStateFromTmx(embededTmx);
			add(extraLife);
			super.create();
			extraLife = new ExtraLife( -100, -100);
			add(extraLife);
		//	timeToBonus = new FlxText(100, 100, 100, "");
		//	add(timeToBonus);
			
		}
		
		protected function spawnABonusItem():void {
			extraLife.reset(FlxG.width, Math.random() * FlxG.height/2);
		}
		
		private function gainALife(extraLife:ExtraLife,bullet:Bullet):void {
			extraLife.kill();
			spawnGibs(bullet);
			currentLives++;
		}
		override public function update():void 
		{
			FlxU.overlap(extraLife, bullets, gainALife);
			
			if (instructions.x < -instructions.width) instructions.x = FlxG.width;
			
			if (bonusSpawnTimer > 0) bonusSpawnTimer -= FlxG.elapsed;
			if (bonusSpawnTimer < 0) {
				spawnABonusItem();
				bonusSpawnTimer = bonusSpawnInterval;
			}
			
			//timeToBonus.text = bonusSpawnTimer.toString();
			
			
			
			if (FlxG.keys.Q)
			{
				FlxG.music.destroy();
				FlxG.state = new NextLevelChooser(0, currentDifficultyLevel);				
			}
			
			if (FlxG.keys.justReleased("M")) 
			{
				if (FlxG.music.playing == true) {
					FlxG.music.fadeOut(0.4, true);
					FlxG.mute = true;
					} else {
						FlxG.music.fadeIn(0.4);
						FlxG.mute = false;
					}
				
			}
			
			
			
			//Mouse.hide();
			displayTargetsLeft(targetsRequired, targetsDestroyed);
			clockHand.angle = -((timeOfLevel*360)/totalTime)-180;
			displayLivesLeft();
			//displayBulletsLeft();
			
			
			if (FlxG.mouse.justReleased()) shoot();	
			if (FlxG.mouse.justPressed()) bulletsFired++;
			FlxU.overlap(bullets, targets, countHits);
			FlxU.overlap(bullets, targets, damageTarget);
			FlxU.overlap(bullets, forbiddenTargets, damageTarget);
			nothingIsCovered();
			FlxU.overlap(obstacleGraphics,targets, hideTarget);
			FlxU.overlap(obstacles, targets, stopTarget);
			
			if (levelTimedOut()) { if (objectiveCompleted(this.targetsRequired, this.targetsDestroyed)&&!dontDoThis) {
				winLevel();
			}else loseLevel();}
			
			collide();
			super.update();
		}
		
		private function countHits(bullet:Bullet,targer:Breakable):void {
			bulletsHit++;
		}
		
		private function nothingIsCovered():void {
			var i:int;
			for (i = 0; i < targets.members.length; i++)
			{
				targets.members[i].isCovered = false;
				targets.members[i].targetIsReached = false;
			}
		}
		
		protected function stopTarget(obstacle:Obstacle,target:Breakable):void {
			
			target.velocity.x=target.velocity.y = 0;
			target.targetIsReached = true;
			obstacle.kill();
			
		}
		
		protected function hideTarget(obstacle:ObstacleGraphic,target:Breakable):void {
			
			target.isCovered = true;
			
			
		}
		
		
		
		private function spawnObject(obj:TmxObject):void
		{
			//Add game objects based on the 'type' property
			switch(obj.type)
			{
				
				
			}
		}

		
		private function loadStateFromTmx(TMXFile:Class):void
		{			
			//HUD initialization
			add(livesCounter);
			add(targetsCounter);
			add(bulletsCounter);
			
			timeLeftTxt = new FlxText(10, 20, 100);
			add(timeLeftTxt);
			
			bullets = new FlxGroup();
			add(bullets);
			
			targets = new FlxGroup();
			add(targets);
			
			forbiddenTargets = new FlxGroup();
			add(forbiddenTargets);
			
			obstacles = new FlxGroup();
			add(obstacles);
			
			obstacleGraphics = new FlxGroup();
			add(obstacleGraphics);
			
			//O kwdikas pou dimiourgei to roloi
			clock = new Clock(FlxG.width-108,8);
			clock.canCollide = false;
			add(clock);
			clockHand = new ClockHand(clock.x + (clock.width / 2), clock.y+15);
			clockHand.canCollide = false;
			clockHand.angle -= 180 ;
			add(clockHand);
			
			
			//TMX stuff below...
			var tmx:TmxMap = new TmxMap(new XML( new TMXFile));
			
			wall = new FlxTilemap();
			//generate a CSV from the layer 'map' with all the tiles from the TileSet 'tiles'
			var mapCsv:String = tmx.getLayer('background').toCsv(tmx.getTileSet('tiles'));
			wall.loadMap(mapCsv, ImgTiles,8,8);
			wall.canCollide = true;
			
			instructions = new FlxText( -10, -10, FlxG.width+150);
			instructions.velocity.x = -100;
			add(instructions);
			
			add(wall);
			
			
			var group:TmxObjectGroup = tmx.getObjectGroup('objects');
			for each(var object:TmxObject in group.objects)
				spawnObject(object);
				
			
		}
		
		
		protected function displayLivesLeft():void {
			livesCounter=new HUDCounter(initialHeartX, initialHeartY, Heart, currentLives,livesArray,"horizontal",200);
		}
		
		private function displayTimeLeft():Number {
			timeLeftTxt.text = Math.floor(timeOfLevel) + " seconds left";
			return (timeOfLevel);
		}
		
		protected function displayBulletsLeft():void {
			bulletsCounter = new HUDCounter(initialBulletX, initialBulletY, GUI.Bullet, bulletsLeft, bulletsArray, "horizontal", 25);
			//trace("Bullets left "+bulletsLeft);
		}
		
		protected function displayTargetsLeft(objective:int,current:int):void {
			var targetsLeft:int = objective-current;
			targetsCounter = new HUDCounter(initialTargetX, initialTargetX, Target, targetsLeft, targetsArray);
			//trace("Targets left " + targetsLeft);
		}
		
		protected function damageTarget(bullet:Bullet, target:Breakable):void {
			if(target.isCovered==false&&FlxG.mouse.justReleased())
			{target.health--; bullet.kill(); }
			if (target.health <=0) {
				if(targetsArray.length>0)targetsArray.pop().kill();
				target.kill();
				spawnGibs(bullet);
				targetsDestroyed++;
			}
			if (target.isForbiddenTarget) dontDoThis = true;
			
		}
		
		protected function spawnGibs(target:FlxSprite):void {
			var gibs:FlxEmitter = createEmitter();
			gibs.at(target);
		}
		
		protected function createEmitter():FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.delay = 5;
			emitter.gravity = 1000;
			emitter.maxRotation = 0;
			emitter.setXSpeed(-100, 100);
			emitter.setYSpeed(-100, 500);
			var particles: int = 10;
			for(var i: int = 0; i < particles; i++)
			{
				var particle:FlxSprite = new FlxSprite();
				particle.createGraphic(2, 2, 0xFFFFFFFF);
				particle.exists = false;
				emitter.add(particle);
			}
			emitter.start();
			add(emitter);
			return emitter;
		}
		
		protected function spawnTarget(target:Breakable):void {
			if (target.isForbiddenTarget == false) targets.add(target);
			if (target.isForbiddenTarget) forbiddenTargets.add(target);
		}
		
		protected function spawnObstacle(_obstacle:Obstacle):void {
			obstacles.add(_obstacle);
			
		}
		
		protected function spawnObstacleGraphic(_graphic:ObstacleGraphic):void {
			obstacleGraphics.add(_graphic);
		}
		
		protected function shoot():void
		{
			if(bulletsLeft>0){
				if(bulletsArray.length>0)bulletsArray.pop().kill();
				bullets.add(new Bullet(FlxG.mouse.screenX, FlxG.mouse.screenY));
				FlxG.flash.start(0xffffffff, 0.1);
				FlxG.play(shotSound);
				bulletsLeft--;
			}else {
				FlxG.play(EmptyGunSnd);
			}
			
			
		}
		
		protected function winLevel():void {
			if (NextLevelChooser.replay == false) globalScore++ else {currentDifficultyLevel++;globalScore++}
			FlxG.state = new NextLevelChooser(currentLives, currentDifficultyLevel);
			
		}
		
		protected function loseLevel():void {
			currentLives--;
			FlxG.state = new NextLevelChooser(currentLives, currentDifficultyLevel);
		}
		
		protected function objectiveCompleted(targetsToWin:int,targetsDestroyed:int):Boolean
		{
			if (targetsDestroyed >= targetsToWin) return true else return false;
		}
		
		private function levelTimedOut():Boolean
		{
			if (timeOfLevel > 0) { 
				timeOfLevel -= FlxG.elapsed;
				return false;
				
				}else return true;
						
		}
		
		protected function hideHUD():void {
		//	targetsLeftTxt.visible = false;
		//	timeLeftTxt.visible = false;
		//	livesCounter.visible = false;
		}
		
		protected function showHUD():void {
		//	targetsLeftTxt.visible = true;
		//	timeLeftTxt.visible = true;
		//   livesCounter.visible = true;
		}
		
		protected function hideTheClock():void {
			clock.visible = false;
			clockHand.visible = false;
		}
		
	
		
	}

}