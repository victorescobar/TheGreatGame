package
{
 import flash.display.Sprite;
 import flash.display.DisplayObject;
 import flash.events.Event;
 import flash.events.KeyboardEvent;
 import flash.geom.Point;
 import flash.ui.Keyboard;
 import flash.display.Stage;
 import flash.filters.DisplacementMapFilter;

    public class Avatar extends Sprite implements ICollidable
	{                                           // Left              Up               Right                 Down                     shift               grab              menu             rotate
     public static const PLAYER1_KMAP:Array  = [Keyboard.Q,    Keyboard.NUMBER_2, Keyboard.E,            Keyboard.W,           Keyboard.NUMBER_3, Keyboard.NUMBER_1, Keyboard.NUMPAD_1, Keyboard.LEFT];
     public static const PLAYER2_KMAP:Array  = [Keyboard.Z,    Keyboard.S,        Keyboard.C,            Keyboard.X,           Keyboard.D,        Keyboard.A,        Keyboard.NUMPAD_2, Keyboard.UP];
     public static const PLAYER3_KMAP:Array  = [Keyboard.R,    Keyboard.NUMBER_5, Keyboard.Y,            Keyboard.T,           Keyboard.NUMBER_6, Keyboard.NUMBER_4, Keyboard.NUMPAD_3, Keyboard.RIGHT];
     public static const PLAYER4_KMAP:Array  = [Keyboard.V,    Keyboard.G,        Keyboard.N,            Keyboard.B,           Keyboard.H,        Keyboard.F,        Keyboard.NUMPAD_4, Keyboard.DOWN];
     public static const PLAYER5_KMAP:Array  = [Keyboard.U,    Keyboard.NUMBER_8, Keyboard.O,            Keyboard.I,           Keyboard.NUMBER_9, Keyboard.NUMBER_7, Keyboard.NUMPAD_5,	Keyboard.SHIFT];
     public static const PLAYER6_KMAP:Array  = [Keyboard.M,    Keyboard.K,        Keyboard.NUMPAD_0,     Keyboard.SEMICOLON,   Keyboard.L,        Keyboard.J    ,    Keyboard.NUMPAD_6, Keyboard.SPACE];
     public static const PLAYER7_KMAP:Array  = [Keyboard.P,    Keyboard.MINUS,    Keyboard.RIGHTBRACKET, Keyboard.LEFTBRACKET, Keyboard.EQUAL,    Keyboard.NUMBER_0, Keyboard.NUMPAD_7, Keyboard.ENTER];
     public static const KEYBOARD_KMAP:Array = [Keyboard.LEFT, Keyboard.UP,       Keyboard.RIGHT,        Keyboard.DOWN,        Keyboard.SHIFT,    Keyboard.SPACE,    Keyboard.ENTER];
	 
	 public static const KEYMAPS:Array 	   	 = [PLAYER1_KMAP, PLAYER2_KMAP, PLAYER3_KMAP, PLAYER4_KMAP, PLAYER5_KMAP, PLAYER6_KMAP, PLAYER7_KMAP ]; 
// ------------------------------------------------------------------------------------------------------------------ 
	 public static const GRAB 			 = "GRABBING";
	 public static const CLICK_BUTTON	 = "CLICKING";
 	 public static const UNGRAB			 = "UNGRABBING";
	 public static const ROTATE			 = "ROTATING";
	 public static const OWN			 = "OWN";
	 public static const OPEN_MENU		 = "OPEN_MENU";
	 public static const CLOSE_MENU		 = "CLOSE_MENU";
// ==================================================================================================================	 
	 public var player:Player;
	 public var tempTerritory:Territory;
	 public var nextTerritory:Territory;
// ------------------------------------------------------------------------------------------------------------------ 
	 private var point:Point = new Point();
	 private var marker:Marker;
	 private var playerMenu:PlayerMenu;
	 private var territory:Territory;
// ==================================================================================================================	 
	 public var territoryArray:Array		 = [];
// ------------------------------------------------------------------------------------------------------------------ 
	 //                                        [left,   up,   right, down,  shift, grab,  menu,  rotate]
	 private var actionArray:Array 			 = [false, false, false, false, false, false, false, false]; 
	 private var keysArray:Array;						 
// ==================================================================================================================	 
	 public var menuOpen:Boolean;
// ------------------------------------------------------------------------------------------------------------------ 
	 private var isOwn:Boolean;
     private var isGrabbing:Boolean;
	 private var isPressing:Boolean;
	 private var isOver:Boolean;
// ==================================================================================================================	 
	 public var markerX:uint;
	 public var markerY:uint;
// ------------------------------------------------------------------------------------------------------------------ 
	 private var color:uint;
	 private var centerX:uint;
	 private var centerY:uint;
//===================================================================================================================
		public function Avatar(player:Player, marker:Marker, playerMenu:PlayerMenu, xPos:uint, yPos:uint, keysArray:Array=null, color=0x000000):void 
		{
		 this.player 				= player; // Assign a "Player"
		 this.marker				= marker as Marker; // Assign "Marker"
		 this.playerMenu 			= playerMenu as PlayerMenu; // Assign "PlayerMenu"
		 centerX 					= player.orientationPoint.x; // These points are necessary for relative..
		 centerY 					= player.orientationPoint.y; // up/down/left/right movement calculations
		 this.x = point.x = markerX = xPos; // Set start positions for "Avatar" and "Point"(for avatar movement) while
		 this.y = point.y = markerY	= yPos;	// also setting the "Marker" position for orientation calculations
		 this.keysArray 			= (keysArray == null) ? KEYBOARD_KMAP : keysArray; // if no determined keysArray, use KEYBOARD_KMAP
		 this.color 				= color; // Set "Avatar" color.
		 draw();
		 
		(stage == null) ? addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true) : init();
        }
// ------------------------------------------------------------------------------------------------------------------ 
       	private function init(e:Event=null):void 
		{
         stage.addEventListener(KeyboardEvent.KEY_DOWN, key_down,   false, 0, true); // Run Listener for :KeyDown:
         stage.addEventListener(KeyboardEvent.KEY_UP,   key_up,     false, 0, true); // Run Listener for :KeyUp:
         stage.addEventListener(Event.ENTER_FRAME,      move_point, false, 0, true); // Run Listener for :MovePoint:
         stage.addEventListener(Event.ENTER_FRAME,      move_avatar,false, 0, true); // Run Listener for :MoveAvatar:
		 this.addEventListener(Event.REMOVED_FROM_STAGE, clean, false, 0, true); // Remove Listener for :Clean: (when "Avatar" is removed from stage)
		 this.removeEventListener(Event.ADDED_TO_STAGE, init); // Run :Init: when "Avatar" is added to stage
		 player.avatarCollider.add_object(this, "A"); // Add "Avatar" to AvatarGroupCollider(A)
        }
// ------------------------------------------------------------------------------------------------------------------ 
		private function clean(e:Event):void
		{
		 stage.removeEventListener(KeyboardEvent.KEY_DOWN, key_down); // Remove Listener for :KeyDown:
         stage.removeEventListener(KeyboardEvent.KEY_UP, key_up); // Remove Listener for :KeyUp:
         stage.removeEventListener(Event.ENTER_FRAME, move_point); // Remove Listener for :MovePoint:
         stage.removeEventListener(Event.ENTER_FRAME, move_avatar); // Remove Listener for :MoveAvatar:
		 this.removeEventListener(Event.REMOVED_FROM_STAGE, clean); // Remove Listener for :Clean:
		 this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true); // Run Listener for :Init: (when "Avatar" is added to stage)
		 this.player.avatarCollider.remove_object(this, "A"); // Remove "Avatar" from AvatarGroupCollider(A)
		}
// ------------------------------------------------------------------------------------------------------------------ 
        private function draw():void // Draws Avatar
		{
         const radius = 1.8; // Determines size of Avatar
		 
		 graphics.lineStyle(1,0x000000); // Determine line style (solid, dotted, etc)
		 graphics.beginFill(color); // Fill in borders of "Avatar" with player color
         graphics.drawCircle(0, 0, radius); // Draw the "Avatar"
         graphics.endFill(); // End color fill
        }
// ------------------------------------------------------------------------------------------------------------------ 
        private function key_down(e:KeyboardEvent):void // Determine actions based on Key Presses
		{
         var index:int = keysArray.indexOf(e.keyCode); // Make "Index" equal which ever index of "keysArray" that was pressed
		 
	     	if ( index == -1 ) { return; } // When a key is pressed...
             actionArray[index] = true; // make whichever index of "actionArray" that was pressed equal [True] (for Movement keys)
			
			if ( index == 5 ) // If "Grab" is pressed
			{
			 	if(! isGrabbing)
			 	{
			 	dispatchEvent(new Event(GRAB)); // Send Event "GRAB"
			 	} 
			 isGrabbing = true; // Set "isGrabbing" to [True]... (this is to limit other actions while moving objects)
			}
			
			if ( index == 6 ) // If "Open/Close PlayerMenu" is pressed
			{
			 	if(! isPressing) // If "isPressing" is [false] (this will always be false when first pressed
				{
					if(! isGrabbing) // Check to make sure you are not currently "Grabbing" an object... if [False]
					{
						if(menuOpen) // If PlayerMenu is Open.
						{
						 this.player.remove_from_stage(playerMenu, stage); // Remove "PlayerMenu" from stage
						 this.player.add_to_stage(marker, stage); // Add "Marker" to stage
						} else { // If PlayerMenu is Closed.
						 this.player.remove_from_stage(marker, stage); // Remove "Marker" from stage
						 this.player.add_to_stage(playerMenu, stage); // Add "PlayerMenu" to stage
						}
					 isPressing = true;	// Make isPressing True so function only runs once..
					}					// when button is held down accidentaly or intentionaly.
				}
			}
			 
			if ( index == 7 ) // If "Rotate" is pressed
			 dispatchEvent(new Event(ROTATE)); // Send Event "ROTATE"
        	}
// ------------------------------------------------------------------------------------------------------------------ 
        private function key_up(e:KeyboardEvent):void // Determine actions based on Key Releases
		{
         var index:int = keysArray.indexOf(e.keyCode); // Make "Index" equal which ever index of "keysArray" that was pressed

            if ( index == -1 ) { return; } // When a key is pressed...
             actionArray[index] = false; // make whichever index of "actionArray" that was pressed equal [True] (for Movement keys)
			
			if ( index == 5 ) // If "Grab" is released
			{
			 dispatchEvent(new Event(UNGRAB)); // Send Event "UNGRAB"
			 isGrabbing = false; // Set "isGrabbing" to [False]... (this is to allow Grabbing a new objects)
			}
			
			if (index == 6) // If "Open/Close PlayerMenu" is released
			{
			 isPressing = false; // Make isPressing [False] so that "PlayerMenu" can be opened or closed again
			}
        }
// ------------------------------------------------------------------------------------------------------------------ 
        private function move_point(e:Event):void
		{
		 const LEFT 		 = actionArray[0]; // Make LEFT equal the boolean state of actionArray[0]
		 const UP 		  	 = actionArray[1]; // Make UP equal the boolean state of actionArray[1]
		 const RIGHT 		 = actionArray[2]; // Make RIGHT equal the boolean state of actionArray[2]
		 const DOWN 		 = actionArray[3]; // Make DOWN equal the boolean state of actionArray[3]
		 const TURBO 		 = actionArray[4]; // Make TURBO equal the boolean state of actionArray[4]
         const velocity	 	 = 3; // Determines the speed of the "Point" which the "Avatar" follows
		 const turboFactor   = 3; // Determines the increases in acceleration, if TURBO is pressed
		  
		 var acceleration = 2.05; // Determines the default acceleration value
		 var totalDisplacement:Number; // Total distance from "Marker" to Center Point of stage (Hypotenuse)
		 var xRate:Number; // This is the "Run" of the distance between MarkerX and the X coordinate of the Center Point of stage
		 var yRate:Number; // This is the "Rise" of the distance between MarkerY and the Y coordinate of the Center Point of stage
		  
		 // Hypotenuse equals the |-sqrt-| of |--------A Squared----------| plus |-------------B Squared----------------|
		 totalDisplacement 		= Math.sqrt(Math.pow((centerY - markerY),2)) + Math.sqrt(Math.pow((centerX - markerX),2));
		 xRate 					= (centerY - markerY)/ totalDisplacement; // This calculates the rate of X movement (Depending on the placement of the Marker in relation to the Center Point of stage)
		 yRate 					= (centerX - markerX)/ totalDisplacement; // This calculates the rate of Y movement (Depending on the placement of the Marker in relation to the Center Point of stage)
		 
        if (TURBO)
		{
         acceleration *= turboFactor // increase acceleration by the factor of turbo
		}
        if (LEFT)
		{
		 point.x += (velocity * xRate) * acceleration; // Move "Point" X value this much
		 point.y -= (velocity * yRate) * acceleration; // Move "Point" Y value this much
		}
		if (UP)
		{ 
         point.x += (velocity * yRate) * acceleration; // Move "Point" X value this much
		 point.y += (velocity * xRate) * acceleration; // Move "Point" Y value this much
		}
		if (RIGHT)
        { 
		 point.x -= (velocity * xRate) * acceleration; // Move "Point" X value this much
		 point.y += (velocity * yRate) * acceleration; // Move "Point" Y value this much
		}
		if (DOWN)
		{ 
         point.x -= (velocity * yRate) * acceleration; // Move "Point" X value this much
		 point.y -= (velocity * xRate) * acceleration; // Move "Point" Y value this much
		}
	}
// ------------------------------------------------------------------------------------------------------------------ 
        private function move_avatar(e:Event):void
		{
		 const resistance = .20; // Determines how slowly or quickly the Avatar follows "Point"
			
          x += (point.x - x) * resistance; // Make "Avatar" X increase or decrease by the distance between "Avatar" and "Point" multiplied by resistance (with each iteration increasing or decreasing less) 
          y += (point.y - y) * resistance; // Make "Avatar" Y increase or decrease by the distance between "Avatar" and "Point" multiplied by resistance (with each iteration increasing or decreasing less)

          point.x = ( point.x < 0 ) ? 0 : point.x; // If "Point" is leaving the stage (left) stop it
          point.x = ( point.x > stage.stageWidth ) ? stage.stageWidth : point.x; // If "Point" is leaving the stage (right) stop it
          point.y = ( point.y < 0 ) ? 0 : point.y; // If "Point" is leaving the stage (top) stop it
          point.y = ( point.y > stage.stageHeight ) ? stage.stageHeight : point.y; // If "Point" is leaving the stage (bottom) stop it
        }
// ------------------------------------------------------------------------------------------------------------------ 
        public function get grabbing():Boolean // I think Ryan put this here but I never use it to find the state of "Grab"
		{
         return actionArray[5]
        }
// ------------------------------------------------------------------------------------------------------------------ 		
		public function collide(obj:DisplayObject):void // Determine what happens when "Avatar" is in a collision
		{
		 var object:Object; // This will act as a vessal for the "obj" in collision with "Avatar" in order to determine the owner of "obj"
		 
			if(obj is Marker) // If "obj" is "Marker"
			{
			 object = obj as Marker; // Set object as "Marker"
				  
				if(object.player == this.player) // If it is my "Marker"
				{
				 
				}
			}
			
			if(obj is PlayerMenu) // If "obj" is "PlayerMenu"
			{
			 object = obj as PlayerMenu; // Set object as "PlayerMenu"

				if(object.player == this.player) // If it is my "PlayerMenu"
				{
				 
				}
			}
				
			if(obj is Territory) // If "obj" is "Territory"
			{
			 object = obj as Territory; // Set object as "Territory"
			 territoryArray.push(obj); // Push "Territory" to the last index of territoryArray
			 
			 tempTerritory = territoryArray[0] as Territory; // Make tempTerritory equal to first index of territoryArray (this is necessary for territory display problems involving colliding with two or more territories simultaneously)
			 playerMenu.country_field(tempTerritory, false);// Update "PlayerMenu" with territory information of tempTerritory (which does not change if any new territory is collided with or uncolided with)	
				if(object.player == this.player) // If it is my "Territory"
				{
				 territory = obj as Territory; // Set territory as "Territory"
				}
			} 
		}
		
		public function un_collide(obj:DisplayObject):void // Determine what happens when "Avatar" is leaving a collision
		{
	 	 var object:Object; // This will act as a vessal for the "obj" in uncolliding with "Avatar" in order to determine the owner of "obj"
			
			if(obj is Avatar) // If "obj" is "Avatar"
			{
			 
			}

			if(obj is Marker) // If "obj" is "Marker"
			{
			 object = obj as Marker;// Set object as "Marker"

				if(object.player == this.player) // If it is my "Marker"
				{
				 
				}
			}

			if(obj is PlayerMenu) // If "obj" is "PlayerMenu"
			{
			 object = obj as PlayerMenu;// Set object as "PlayerMenu"

				if(object.player == this.player) // If it is my "PlayerMenu"
				{
				 
				}
			}

			if(obj is Territory) // If "obj" is "Territory"
			{
			 territoryArray.splice(territoryArray.indexOf(obj), 1); // Remove "obj" from territoryArray
			 object = obj as Territory; // Set object as "Territory"
				
					if(! territoryArray.length) // If you are no longer colliding with ANY territory
					{
			  		 playerMenu.country_field(tempTerritory, true);
					 tempTerritory = null; // Set tempTerritory to [NULL]
					} else { // If you are still colliding with SOME territory
					 tempTerritory = territoryArray[0]; // Set tempTerritory to whichever country is now at index[0] in tempTerritory Array
					 playerMenu.country_field(tempTerritory, false);
					}
				 
				
				if(object.player == this.player) // If it is my "Territory"
				{
				 territory = obj as Territory; // Set territory as "Territory"
				}
			} 
		}
// ------------------------------------------------------------------------------------------------------------------ 
	}
}
