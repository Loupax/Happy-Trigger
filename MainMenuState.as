package  
{
	import GUI.Boom;
	import MainMenuBtns.MenuBtn;
	import MainMenuBtns.MinigameSelectBtn;
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import targetPkg.Bottle;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	//import mochi.as3.*;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class MainMenuState extends FlxState
	{
		//Happy Trigger
		
		[Embed(source = '../lib/img/Bottle.png')]private var ImgBottle:Class;
		[Embed(source = '../lib/img/pixelatedLightbulb.png')] private var ImgLamp:Class;
		[Embed(source = '../lib/img/meteor.png')] private var ImgMeteor:Class;
		[Embed(source = '../lib/img/ninja.png')] private var ImgNinja:Class;
		[Embed(source = '../lib/img/FlyAnimation.png')] private var ImgFly:Class;
		
		
		[Embed(source = '../lib/img/GameOverScreenBg.png')]private var ImgBg:Class;
		[Embed(source = '../lib/img/StartBtn.png')] private var ImgStartBtn:Class;
		[Embed(source = '../lib/img/SponsorLink.png')] private var ImgSponsor:Class;
		[Embed(source = '../lib/img/GameSelect.png')] private var ImgGameSelect:Class;
		
		private var sponsorSpr:FlxSprite;
		private var sponsorBtn:FlxButton;
		private var gameSelectBtn:MenuBtn;
		private var gameSelectionBtns:FlxGroup;
		
		[Embed(source = '../lib/img/HappyTriggerTxt.png')]private var TitleGraphic:Class;
		private var TitleSpr:FlxSprite;
		
		private var startBtnSpr:FlxSprite;
		private var backGround:FlxSprite;
		private var startBtn:FlxButton;
		private var clickThese:FlxText;
		
		override public function create():void 
		{			
			//FlxG.showBounds = true;
			if (NextLevelChooser.musicControler != null) NextLevelChooser.musicControler = null;
			FlxG.mouse.show();
			//background code
			backGround = new FlxSprite(0, 0, ImgBg);
			add(backGround);
			
			//Start button code
			startBtnSpr = new FlxSprite(0, 0);
			startBtnSpr.loadGraphic(ImgStartBtn, true,false,90,30);
			startBtnSpr.addAnimation("idle", [0, 1, 2], 6);
			startBtn = new FlxButton(FlxG.width - 150, FlxG.height/2,startPlaying);
			startBtn.loadGraphic(startBtnSpr);
			add(startBtn);
			
			//Game sellect button
			//gameSelectBtn = new MenuBtn(startBtn.x, startBtn.y + startBtn.height +5, ImgGameSelect, displayGameSelection);
			//add(gameSelectBtn);
			
			//sponsor button code
			sponsorSpr = new FlxSprite(0, 0,ImgSponsor);
			sponsorBtn = new FlxButton(43, 245, visitSponsor);
			sponsorBtn.loadGraphic(sponsorSpr);
			//add(sponsorBtn);
			
			//GameTitle graphics code
			TitleSpr = new FlxSprite(0,0);
			TitleSpr.loadGraphic(TitleGraphic);
			TitleSpr.angle -= 25;
			var boom:Boom = new Boom(50,0)
			boom.currentAnimation = "static";
			boom.color = 0xFFFF00;
			add(boom);
			add(TitleSpr);
			
			//Creator name
			var copyrightText:FlxText = new FlxText(sponsorBtn.x, sponsorBtn.y - 20, 500, "Created by Kostas Loupasakis (c)");
			copyrightText.color = 0xFF000000;
			add(copyrightText);
			
			gameSelectionBtns = new FlxGroup();
			add(gameSelectionBtns);
			createLevelChooser();
			super.create();
			clickThese = new FlxText(385, 70, 200, "^^^Choose minigame to play!^^^");
			clickThese.color = 0xff000000;
			add(clickThese);
			
			var keys:FlxText = new FlxText(8, FlxG.height - 25, FlxG.width, "Q: Submit score/M: Mute sounds");
			keys.size = 20;
			keys.color = 0xff000000;
			add(keys);
			
		}
		
		private function createLevelChooser():void {
			var bottleLevelBtn:MinigameSelectBtn = new MinigameSelectBtn(350, 10, playBottleLevel, ImgBottle,18,49);
			gameSelectionBtns.add(bottleLevelBtn);
			
			var meteorLevelBtn:MinigameSelectBtn = new MinigameSelectBtn(360, -10, playMeteorLevel, ImgMeteor);
			meteorLevelBtn.thisBtnSpr.scale.x = meteorLevelBtn.thisBtnSpr.scale.y *= 0.5;
			meteorLevelBtn.thisBtnSpr.width = meteorLevelBtn.thisBtnSpr.height *= 0.5;
			gameSelectionBtns.add(meteorLevelBtn);
			
			var ninjaLevelBtn:MinigameSelectBtn = new MinigameSelectBtn(440, 30, playNinjaLevel, ImgNinja, 20, 20);
			ninjaLevelBtn.thisBtnSpr.scale.x = ninjaLevelBtn.thisBtnSpr.scale.y *= 2;
			ninjaLevelBtn.thisBtnSpr.width = ninjaLevelBtn.thisBtnSpr.height *= 2;
			gameSelectionBtns.add(ninjaLevelBtn);
			
			var lampLevelBtn:MinigameSelectBtn = new MinigameSelectBtn(470, -10, playLampLevel, ImgLamp,50,100);
			lampLevelBtn.thisBtnSpr.scale.x = lampLevelBtn.thisBtnSpr.scale.y *= 0.5;
			//lampLevelBtn.thisBtnSpr.width *= lampLevelBtn.thisBtnSpr.scale.x;
			//lampLevelBtn.thisBtnSpr.height *= lampLevelBtn.thisBtnSpr.scale.y;
			gameSelectionBtns.add(lampLevelBtn);
			
			var flyLevelBtn:MinigameSelectBtn = new MinigameSelectBtn(490, -10, playFlyLevel, ImgFly);
			flyLevelBtn.thisBtnSpr.scale.x = flyLevelBtn.thisBtnSpr.scale.y *= 0.5;
			gameSelectionBtns.add(flyLevelBtn);
			
		}
		
		private function playBottleLevel():void {
			NextLevelChooser.replay = true;
			NextLevelChooser.defaultLevel = 1;
			FlxG.state = new NextLevelChooser(5, 1);
		}
		
		private function playMeteorLevel():void {
			NextLevelChooser.replay = true;
			NextLevelChooser.defaultLevel = 5;
			FlxG.state = new NextLevelChooser(5, 1);		}
			
		private function playNinjaLevel():void {
			NextLevelChooser.replay = true;
			NextLevelChooser.defaultLevel = 4;
			FlxG.state = new NextLevelChooser(5, 1);
		}
		
		private function playLampLevel():void {
			NextLevelChooser.replay = true;
			NextLevelChooser.defaultLevel = 2;
			FlxG.state = new NextLevelChooser(5, 1);
		}
		
		private function playFlyLevel():void {
			NextLevelChooser.replay = true;
			NextLevelChooser.defaultLevel = 3;
			FlxG.state = new NextLevelChooser(5, 1);	
		}
		override public function update():void 
		{
			startBtnSpr.play("idle");
			trace("X:" + FlxG.mouse.screenX + " Y:" + FlxG.mouse.screenY);
			super.update();
		}
		
		private function visitSponsor():void {
			var link:URLRequest = new URLRequest ("http://www.google.com");
			navigateToURL(link, "_blank");
		}
		private function startPlaying():void {
			//MochiEvents.startPlay();
			NextLevelChooser.replay = false;
			FlxG.state = new NextLevelChooser();
		}
		
	}

}