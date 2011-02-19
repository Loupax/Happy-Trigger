package com.loupax.HUD 
{
	import flash.display.Graphics;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Loupax
	 */
	public class HUDCounter extends FlxSprite
	{
		private var hudObject:FlxSprite;
	
		public function HUDCounter(X:int,Y:int,Graphic:Class,currentElements:int,hudObjectArray:Array,orientation:String="vertical",gap:int=25,maxElements:int=10) 
		{
			var currentCount:int = hudObjectArray.length;
			if (hudObjectArray.length > maxElements) {
				currentCount = maxElements;
			}
			if ((currentCount < currentElements)&&(currentCount<maxElements)){
				if (orientation == "horizontal") {
						hudObject = new Graphic((X * currentCount) + gap, Y);
						hudObjectArray.push(hudObject);
					}
				
				
				if (orientation == "vertical") {
					hudObject = new Graphic(X, (Y * currentCount) + gap);
					hudObjectArray.push(hudObject);
				}
			}
			
			
			FlxG.state.add(hudObject);
			
		}
		
		override public function update():void 
		{
			super.update();
		}
		
	}

}