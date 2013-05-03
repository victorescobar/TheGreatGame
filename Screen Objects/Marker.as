package
{
 import flash.display.MovieClip;
 import flash.display.DisplayObject;
 import flash.events.Event;
 import flash.geom.Point;
 import flash.display.Sprite;
	
	public class Marker extends MovieClip implements ICollidable
	{
	 public var player:Player;
// ------------------------------------------------------------------------------------------------------------------ 
	 public var collidingArray:Array = [];
// ==================================================================================================================	 
	 private var avatar:Avatar;
	 private var marker:Marker;
	 private var territory:Territory;
// ------------------------------------------------------------------------------------------------------------------ 
	 private var color:uint;
	 private var resistance:Number	 =	.01;
	 private var avatarColliding:Boolean;
// ==================================================================================================================	 
		public function Marker(player:Player, color:uint, xPos:Number, yPos:Number):void
		{
		 this.player = player; // Assign a "Player"
		 this.color = color; // Set "Marker" color
		 this.x = xPos; // Set start positions
		 this.y = yPos; // Set start positions
		 draw(); // Draw the "Marker"
		 
		(stage == null) ? addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true) : init(); // If stage is [NULL], add listener for :Init:... If stage is not [NULL] run :Init:
		
		}
// ------------------------------------------------------------------------------------------------------------------ 
		private function init(e:Event=null)
		{
		 this.addEventListener(Event.REMOVED_FROM_STAGE, clean, false, 0, true); // Run Listener for :Clean: 
		 this.removeEventListener(Event.ADDED_TO_STAGE, init); // Remove Listener for :Init:
		 orient(); // Set the Rotational angle of the marker
		 
		 player.avatarCollider.add_object(this, "B"); // Add "Marker" to avatarGroupCollider(B)
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function clean(e:Event):void
		{
		 this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		 this.removeEventListener(Event.REMOVED_FROM_STAGE, clean);
		 this.player.avatarCollider.remove_object(this, "B");
		 //this.player.countryCollider.remove_object(this, "B");
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function accept_item(obj:Object):void //
		{
		 	if(obj is Avatar)
			 avatar = obj as Avatar;
		}
// ------------------------------------------------------------------------------------------------------------------ 
		private function draw():void 
		{		
		 this.graphics.lineStyle(1,color);
		 this.graphics.beginFill(color);
		 this.graphics.moveTo(0, -24);
		 this.graphics.lineTo(20, 14);
		 this.graphics.lineTo(-20, 14);
		 this.graphics.lineTo(0, -24);
		 this.graphics.endFill();
		}
		
// ------------------------------------------------------------------------------------------------------------------ 
		private function orient():void
		{
		 var pointX 		= player.orientationPoint.x;
		 var pointY 		= player.orientationPoint.y;
		 var opposite 		= Math.sqrt(Math.pow(this.y - pointY, 2));
		 var hypotenuse 	= Math.sqrt((Math.pow(this.y - pointY, 2))+ Math.pow(this.x - pointX, 2));
		 var angle 			= Math.asin(opposite/hypotenuse)/(Math.PI/180);
		 
			if(x > pointX && y >= pointY)
			 this.rotation = angle - 90;
			 
			if(x <= pointX && y > pointY)
			 this.rotation = 90 - angle;
		  
			if(y <= pointY && x < pointX)
			 this.rotation = angle + 90;
			 
			if(y < pointY && x >= pointX)
			 this.rotation = 270 - angle;
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function collide(obj:DisplayObject):void 
		{
		 var object:Object;
		 collidingArray.push(obj);
		 alpha = 0.3;
		 
		 	if(obj is Avatar)
			{
			 object = obj as Avatar;
				 	
				if(object.player == this.player)
				{
				 avatar.addEventListener(Avatar.GRAB, start_follow, false, 0, true);
				 avatarColliding = true;
				}
			}
			
			if(obj is Territory)
			{
			}
			
			if(obj is PlayerMenu)
			{
			}
		 
		}
// ------------------------------------------------------------------------------------------------------------------ 
		public function un_collide(obj:DisplayObject):void 
		{
		 var object:Object;
		 collidingArray.splice(collidingArray.indexOf(obj), 1);
		 
			if(! collidingArray.length)
			{
			 this.alpha = 1;
			}
		 
		 	if(obj is Avatar)
			{
			 object = obj as Avatar;
				 	
				if(object.player == this.player)
				{
			 	 avatarColliding = false;
				 avatar.removeEventListener(Avatar.GRAB, start_follow);
				}
			}
			
			if(obj is PlayerMenu)
			{
			}
		}
// ------------------------------------------------------------------------------------------------------------------ 
		private function start_follow(e:Event):void
		{
		 stage.addEventListener(Event.ENTER_FRAME, follow, false, 0, true);
		 avatar.addEventListener(Avatar.UNGRAB, stop_follow, false, 0, true);	
		}
// ------------------------------------------------------------------------------------------------------------------ 
		private function stop_follow(e:Event):void
		{
		 stage.removeEventListener(Event.ENTER_FRAME, follow);
		 avatar.removeEventListener(Avatar.UNGRAB, stop_follow);
		 avatar.markerX = this.x;
		 avatar.markerY = this.y;
		 resistance = .01;		
		}
// ------------------------------------------------------------------------------------------------------------------ 
		private function follow(e:Event):void
		{
		 resistance = resistance + (1 - resistance)/10;
		 x += (avatar.x - x) * resistance;
		 y += (avatar.y - y) * resistance;
		 orient();
		}

// ------------------------------------------------------------------------------------------------------------------ 
		private function manual_rotate(e:Event):void
		{
		 trace("finish later");
		}
// ------------------------------------------------------------------------------------------------------------------ 
	}
}
