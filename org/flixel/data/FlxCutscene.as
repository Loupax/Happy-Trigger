package
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import flash.display.MovieClip;
	import flash.media.SoundMixer;
	import flash.events.Event;
	public class FlxCutscene extends FlxState
	{
		//Embed the cutscene swf relative to the root of the Flixel project here
		[Embed(source = 'logo.swf')] private var SwfClass:Class;	 
		//This is the MovieClip container for your cutscene
		private var movie:MovieClip;
		//This is the length of the cutscene in frames
		private var length:Number;
		
		override public function create():void
		{
			movie = new SwfClass();
			//Set your zoom factor of the FlxGame here (default is 2)
			var zoomFactor:int = 2;
			movie.scaleX = 1.0/zoomFactor;
			movie.scaleY = 1.0 / zoomFactor;
			//Add the MovieClip container to the FlxState
			addChildAt(movie, 0);
			//Set the length of the cutscene here (frames)
			length = 100;
			//Adds a listener to the cutscene to call next() after each frame.
			movie.addEventListener(Event.EXIT_FRAME, next);
		}
		private function next(e:Event):void
		{
			//After each frame, length decreases by one
			length--;
			//Length is 0 at the end of the movie
			if (length <= 0)
			{
				//Removes the listener
				movie.removeEventListener(Event.EXIT_FRAME, next);				
				//Stops all overlaying sounds before state switch
				SoundMixer.stopAll();
				//Enter the next FlxState to switch to
				FlxG.state = new PlayState();
			}			
		}
	} 
}