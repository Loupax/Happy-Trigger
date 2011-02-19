package 
{
	import org.flixel.FlxGame
	//import mochi.as3.*;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	[SWF(width = "640", height = "480", backgroundColor = "#000000")] //Set the size and color of the Flash file
	
	
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class Main extends FlxGame
	{
	
		
		public function Main():void 
		{
			super(640, 480, MainMenuState, 1); 
			
		}
		
		
		
	}
	
}