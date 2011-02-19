package  
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxEmitter;
	import targetPkg.LightBulb;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class BlindShooting extends ShootingMinigameState
	{
		public static var blindShootingScore:int;
		private const waitingTime:Number = 1;
		private var waitingTimer:Number = waitingTime;
		
		private const baseTimer:Number=6;
		
		private var howManyLamps:int;
		
		private var getReadySpr:FlxSprite;
		private var lampsAreMovable:Boolean;
				
		[Embed(source = '../lib/img/PlaceYourMouseHere.png')] private var ImgGetReady:Class;
	
		public function BlindShooting(lives:int,difficulty:int,bgColor:uint):void
		{
			FlxState.bgColor = bgColor;
			setDifficultyLevel(difficulty);
			super(howManyLamps, thisStateTime, lives,difficulty);
			trace(difficulty);
		}
		
		override public function create():void 
		{
			
			FlxG.mouse.show();
			getReadySpr = new FlxSprite((FlxG.width / 2) -(230/2), FlxG.height / 2);
			getReadySpr.loadGraphic(ImgGetReady,true,false,235,103);
			getReadySpr.addAnimation("getReady", [0,1],2);
			add(getReadySpr);			
			super.create();
			targets.destroy();
			targets = new FlxGroup();
			instructions.x = Math.random() * FlxG.width;
			instructions.y = FlxG.height - 25;
			instructions.visible = true;
			instructions.color = 0xffffffff;
			instructions.text = "Your mouse cursor it protesting! Where is your god now?";
		}
		
		override public function update():void 
		{
			if (!getReady()) {
				hideHUD();
				getReadySpr.play("getReady");
			}else {
				if(getReady()&&getReadySpr.dead==false){
					FlxG.mouse.hide();
					getReadySpr.kill();
					showHUD();
					
					targets.destroy();
					targets = new FlxGroup();
					add(targets);
					spawnLamps();
					}
			}
			
			
			super.update();
			
		}
		
		private function spawnLamps():Boolean {
			var i:int;
			for (i = 0; i < howManyLamps; i++)
			{
				var lightbulb:LightBulb = new LightBulb(Math.floor(Math.random() * (1 + FlxG.width - 60)), Math.floor(Math.random() * (1 + FlxG.height - 110)));
				if (lampsAreMovable) {
					lightbulb.movable = true;
				}
				spawnTarget(lightbulb);
			}
			return true;
		}
		
		private function getReady():Boolean {
			if (waitingTimer > 0) { waitingTimer -= FlxG.elapsed; return false; }
			else { return true }
		}
		
		override protected function winLevel():void 
		{
				blindShootingScore++;
				super.winLevel();
							
		}
		
		private function setDifficultyLevel(difficulty:int):void {
			if (difficulty <= 5) {
				howManyLamps = difficulty;
				lampsAreMovable = false;
				if (difficulty == 1) thisStateTime = baseTimer;
				if (difficulty == 2) thisStateTime = baseTimer;
				if (difficulty == 3) thisStateTime = baseTimer - 1;
				if (difficulty == 4) thisStateTime = baseTimer - 2;
				if (difficulty == 5) thisStateTime = baseTimer - 2;
			}else {
				howManyLamps = 6;
				thisStateTime = baseTimer - 2;
				lampsAreMovable = false;
			}
		}
		
	}

}