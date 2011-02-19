package net.pixelpracht.geometry
{
	import flash.geom.Rectangle;

	public class Rectangle2D
	{
		
		/**
		 * The x coordinate of the topleft edge of the rectangle.
		 */
		public var x:Number;
		
		/**
		 * The x coordinate of the topleft edge of the rectangle.
		 */
		public var y:Number;
		
		/**
		 * The width of the rectangle.
		 */
		public var width:Number;
		
		/**
		 * The height of the rectangle.
		 */
		public var height:Number;
		
		
		public function get right():Number
		{
			return x + width;	
		}
		
		public function get bottom():Number
		{
			return y + height;
		}
		
		
		/**
		 * Constructor
		 */
		public function Rectangle2D( vx:Number = 0, vy:Number = 0, w:Number = 0, h:Number = 0 )
		{
			x = vx;
			y = vy;
			width = w;
			height = h;
		}
		
		/**
		 * Converts from flash.geom.Rectangle to Rectangle2D.
		 */
		public static function fromRectangle( r:Rectangle ):Rectangle2D
		{
			return new Rectangle2D( r.x, r.y, r.width, r.height );
		}
		
		/**
		 * Moves the vector to be within the rectangle.
		 */
		public function snap(v:Vector2D):Vector2D
		{
			v.x = Math.max(x, Math.min(right, v.x));
			v.y = Math.max(y, Math.min(bottom, v.y));
			return v;
		}
		
		
		/**
		 * Returns the point on or within this rectangle that is closest to the vector.
		 */
		public function snapped(v:Vector2D):Vector2D
		{
			return new Vector2D(Math.max(x, Math.min(right, v.x)), Math.max(y, Math.min(bottom, v.y)));
		}

		/**
		 * Returns 1 if inside, 0 if intersecting and -1 outside.
		 */
		public function getRelation(line:LineSegment2D):Number
		{
			//int x1, int y1, int x2, int y2, 
			var xmax:Number = x + width;
			var ymax:Number = y + height;
			
			var u1:Number = 0.0;
			var u2:Number = 1.0;
			
			var deltaX:Number = (line.end.x - line.start.x);
			var deltaY:Number = (line.end.y - line.start.y);
			
			/*
			* left edge, right edge, bottom edge and top edge checking
			*/
			var pPart:Array = new Array(-deltaX, deltaX, -deltaY, deltaY);
			var qPart:Array = new Array(line.start.x - x, xmax - line.start.x, line.start.y - y, ymax - line.start.y);
			
			for( var i:int = 0; i < 4; i ++ )
			{
				var p:Number = pPart[ i ];
				var q:Number = qPart[ i ];
				
				if( p == 0 && q < 0 )
					return -1;
				
				var r:Number = q / p;
				
				if( p < 0 )
					u1 = Math.max(u1, r);
				else if( p > 0 )
					u2 = Math.min(u2, r);
				
				if( u1 > u2 )
					return -1;					
			}
			
			if( u2 < 1 || u1 < 1 )
				return 0
			else
				return 1;
		}
		
		/**
		 * Constrains a linesegment to fit in the rectangle. Uses Liang Barsky Algorithm.
		 */
		public function clip(line:LineSegment2D):LineSegment2D
		{
			//int x1, int y1, int x2, int y2, 
			var xmax:Number = x + width;
			var ymax:Number = y + height;
			
			var u1:Number = 0.0;
			var u2:Number = 1.0;
			
			var deltaX:Number = (line.end.x - line.start.x);
			var deltaY:Number = (line.end.y - line.start.y);
			
			/*
			* left edge, right edge, bottom edge and top edge checking
			*/
			var pPart:Array = new Array(-deltaX, deltaX, -deltaY, deltaY);
			var qPart:Array = new Array(line.start.x - x, xmax - line.start.x, line.start.y - y, ymax - line.start.y);
			
			for( var i:int = 0; i < 4; i ++ )
			{
				var p:Number = pPart[ i ];
				var q:Number = qPart[ i ];
				
				if( p == 0 && q < 0 )
					return null;
				
				var r:Number = q / p;
				
				if( p < 0 )
					u1 = Math.max(u1, r);
				else if( p > 0 )
					u2 = Math.min(u2, r);
				
				if( u1 > u2 )
					return null;					
			}
		
			if( u2 < 1 )
			{
				line.end.x = (line.start.x + u2 * deltaX);
				line.end.y = (line.start.y + u2 * deltaY);
			}
			if( u1 > 0)
			{
				line.start.x = (line.start.x + u1 * deltaX);
				line.start.y = (line.start.y + u1 * deltaY);
			}
			line.recalc();
			return line;    	
		}
		
		
		/**
		 * Converts from Rectangle2D to flash.geom.Rectangle.
		 */
		public function toRectangle():Rectangle
		{
			return new Rectangle( x, y, width, height );
		}
		
		/**
		 * The area of this rectangle
		 */
		public function get area():Number
		{
			return width * height;
		}
		
	}
}