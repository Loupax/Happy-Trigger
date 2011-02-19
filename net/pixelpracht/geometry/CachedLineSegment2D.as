package net.pixelpracht.geometry
{
	public class CachedLineSegment2D extends LineSegment2D
	{
		public function CachedLineSegment2D(startX:Number=0, startY:Number=0, endX:Number=0, endY:Number=0)
		{
			super(startX, startY, endX, endY);
		}
		
		//returns cached copy
		public static function fromLineSegment(line:LineSegment2D):LineSegment2D
		{
			return new CachedLineSegment2D( line.start.x, line.start.y, line.end.x, line.end.y );			
		}
		
		/**
		 * Make a copy of this line segment.
		 */
		public override function clone():LineSegment2D
		{
			return new CachedLineSegment2D( start.x, start.y, end.x, end.y );
		}
		
		
		private var _direction:Vector2D = null;
		private var _length:Number = 0;
		private var _lengthSquared:Number = 0;
		
		public override function recalc():void
		{
			_direction = end.subtracted(start);
			_length = _direction.length;
			_lengthSquared = _direction.lengthSquared;
		}
		
		/**
		 * A new vector covering the distance from start to end.
		 */		
		public override function get direction():Vector2D
		{
			return _direction;
		}	
		
		/**
		 * The length of this line segment
		 */
		public override function get length():Number
		{
			return _length;
		}
		
		/**
		 * The square of the length of this line segment
		 */
		public override function get lengthSquared():Number
		{
			return _lengthSquared;
		}
		
	}
}