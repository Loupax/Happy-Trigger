package  
{
	import org.flixel.FlxPreloader;
	import mochi.as3.*;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class Preloader extends FlxPreloader
	{
		
		public function Preloader() 
		{
			className = "Main";
			MochiServices.connect("110da6b4494c2772", root);
			MochiEvents.startPlay();

            super();
		}
		
	}

}